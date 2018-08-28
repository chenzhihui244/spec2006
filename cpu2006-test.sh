#!/bin/sh

iso_file=cpu2006-1.2.iso
iso_mnt=/mnt

cpu2006_dir=cpu2006

mount | grep -q "$iso_file" > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
	mount $iso_file $iso_mnt
fi

[ -d $cpu2006_dir ] || {
	mkdir $cpu2006_dir && cp -a $iso_mnt/* $cpu2006_dir
}

# replace config.guess
cp config.guess $cpu2006_dir/tools/src/specsum/build-aux/
cp config.guess $cpu2006_dir/tools/src/tar-1.25/build-aux/
cp config.guess $cpu2006_dir/tools/src/xz-5.0.0/build-aux/
cp config.guess $cpu2006_dir/tools/src/rxp-1.5.0/
cp config.guess $cpu2006_dir/tools/src/make-3.82/config/

# modify Configure of perl
grep -q "aarch64" $cpu2006_dir/tools/src/perl-5.12.3/Configure > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
sed -i 'N;1324atest -d /lib/aarch64-linux-gnu && glibpth="$glibpth /lib/aarch64-linux-gnu /usr/lib/aarch64-linux-gnu"' $cpu2006_dir/tools/src/perl-5.12.3/Configure
fi

# modify stdio.in.h

grep -q "//#undef" $cpu2006_dir/tools/src/tar-1.25/gnu/stdio.in.h
if [ ! $? -eq 0 ]; then
	sed -i '146s%#undef%//#undef%' $cpu2006_dir/tools/src/tar-1.25/gnu/stdio.in.h
fi

grep -q "//_GL_WARN_ON_USE" $cpu2006_dir/tools/src/tar-1.25/gnu/stdio.in.h
if [ ! $? -eq 0 ]; then
	sed -i '147s%_GL_WARN_ON_USE%//_GL_WARN_ON_USE%' $cpu2006_dir/tools/src/tar-1.25/gnu/stdio.in.h
fi

# modify stdio.in.h

grep -q "//#undef" $cpu2006_dir/tools/src/specsum/gnulib/stdio.in.h
if [ ! $? -eq 0 ]; then
	sed -i '161s%#undef%//#undef%' $cpu2006_dir/tools/src/specsum/gnulib/stdio.in.h
fi

grep -q "//_GL_WARN_ON_USE" $cpu2006_dir/tools/src/specsum/gnulib/stdio.in.h
if [ ! $? -eq 0 ]; then
	sed -i '162s%_GL_WARN_ON_USE%//_GL_WARN_ON_USE%' $cpu2006_dir/tools/src/specsum/gnulib/stdio.in.h
fi

[ -f $cpu2006_dir/config/ts2280-2cpu.cfg ] || cp ts2280-2cpu.cfg $cpu2006_dir/config/
[ -f $cpu2006_dir/config/flags/ts2280-gcc4x-flags.xml ] || cp ts2280-gcc4x-flags.xml $cpu2006_dir/config/flags/

build_test() {
	export FORCE_UNSAFE_CONFIGURE=1
	cd $cpu2006_dir/tools/src
	echo y | ./buildtools
	cd -
}

run_test() {
	cd $cpu2006_dir
	. ./shrc

	./bin/runspec -c ts2280-2cpu.cfg all --rate 1
	./bin/runspec -c ts2280-2cpu.cfg all --rate 32
	./bin/runspec -c ts2280-2cpu.cfg all --rate 64
}

build_test
run_test
