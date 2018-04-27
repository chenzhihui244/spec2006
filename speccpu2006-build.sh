#!/bin/bash

SPEC_DIR=speccpu2006

if [ -n $(which yum) ]; then
	yum install -y automake
	yum install -y numactl
	#yum install -y gcc*
	yum install -y gcc
	yum install -y gcc-c++
	yum install -y gcc-gfortran
	yum install -y libgfortran
	#yum install -y *cmp
	#yum install -y cmp*
fi

if [ -n $(which apt-get) ]; then
	apt-get install -y automake
	apt-get install -y numactl
	#apt-get install -y gcc*
	apt-get install -y libgfortran-5-dev
	#apt-get install -y *cmp
	#apt-get install -y cmp*
fi

export FORCE_UNSAFE_CONFIGURE=1

cd $SPEC_DIR/tools/src && echo y | ./buildtools
