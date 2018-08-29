#!/bin/sh

. ./shrc

grep -q "F-fsigned-char" config/flags/Example-gcc4x-flags-revA.xml > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
	sed -i 's%F-funsigned-char%F-fsigned-char%' config/flags/Example-gcc4x-flags-revA.xml
	sed -i '/<\/flagsdescription>/d' config/flags/Example-gcc4x-flags-revA.xml
	cat >> config/flags/Example-gcc4x-flags-revA.xml <<EOF

<flag name="F-fno-aggressive-loop-optimizations"
      class="optimization">
<![CDATA[
<p> 
gnu90 portability
</p>
]]>
</flag>

<flag name="F-std"
      class="portability">
<example>
-std=gnu90
</example>
<![CDATA[
<p> 
gnu90 portability
</p>
]]>
</flag>

</flagsdescription>
EOF
fi


start_time=`date`

./bin/runspec -c lemon-2cpu.cfg all --rate 1
./bin/runspec -c lemon-2cpu.cfg all --rate 64

end_time=`date`

echo "start: ${start_time}"
echo "end: ${end_time}"
