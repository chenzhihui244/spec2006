#!/bin/bash

TEST_SPECINT=yes
TEST_SPECFP=yes

SPEC_DIR=speccpu2006
cd $SPEC_DIR

. ./shrc

if [ "$TEST_SPECINT" = "yes" ]; then
	#./bin/runspec -c lemon-2cpu.cfg int --speed -n 1 --noreportable
	#./bin/runspec -c 2650v4.cfg 471.omnetpp --rate 1 -n 1  --noreportable
	./bin/runspec -c lemon-2cpu.cfg int --rate 1 -n 1 --noreportable
	./bin/runspec -c lemon-2cpu.cfg int --rate 32 -n 1 --noreportable
	./bin/runspec -c lemon-2cpu.cfg int --rate 64 -n 1 --noreportable
fi

if [ "$TEST_SPECFP" = "yes" ]; then
	#./bin/runspec -c lemon-2cpu.cfg fp --speed -n 1 --noreportable
	./bin/runspec -c lemon-2cpu.cfg fp --rate 1 -n 1 --noreportable
	./bin/runspec -c lemon-2cpu.cfg fp --rate 32 -n 1 --noreportable
	./bin/runspec -c lemon-2cpu.cfg fp --rate 64 -n 1 --noreportable
fi
