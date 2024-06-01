#!/bin/bash

# Define las variables de entorno
export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
export BENCHMARK=./src/benchmark
export INPUT_FILE=./data/test.txt
export OUTPUT_FILE=./data/output.txt
export ARGUMENT="1 $INPUT_FILE $OUTPUT_FILE"

# Ejecuta el benchmark utilizando GEM5
time $GEM5_DIR/build/RISCV/gem5.opt \
-d ~/m5out \
$GEM5_DIR/configs/deprecated/example/se.py \
-c $BENCHMARK \
-o "$ARGUMENT" \
-I 300000000 \
--cpu-type=TimingSimpleCPU \
--caches \
--l2cache \
--l1d_size=128kB \
--l1i_size=128kB \
--l2_size=1MB \
--l1d_assoc=2 \
--l1i_assoc=2 \
--l2_assoc=1 \
--cacheline_size=64


