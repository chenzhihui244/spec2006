#!/bin/bash

TEST_SPECINT=no
TEST_SPECFP=yes

SPEC_DIR=speccpu2006
cd $SPEC_DIR

. ./shrc

if [ "$TEST_SPECINT" = "yes" ]; then
	#./bin/runspec -c e5-2650v4.cfg int --speed -n 1 --noreportable
	#./bin/runspec -c e5-2650v4.cfg int --rate 1 -n 1 --noreportable
	./bin/runspec -c e5-2650v4.cfg int --rate 24 -n 1 --noreportable
	./bin/runspec -c e5-2650v4.cfg int --rate 48 -n 1 --noreportable
fi

if [ "$TEST_SPECFP" = "yes" ]; then
	#./bin/runspec -c e5-2650v4.cfg fp --speed -n 1 --noreportable
	./bin/runspec -c e5-2650v4.cfg fp --rate 1 -n 1 --noreportable
	./bin/runspec -c e5-2650v4.cfg fp --rate 24 -n 1 --noreportable
	#./bin/runspec -c e5-2650v4.cfg fp --rate 48 -n 1 --noreportable
fi
