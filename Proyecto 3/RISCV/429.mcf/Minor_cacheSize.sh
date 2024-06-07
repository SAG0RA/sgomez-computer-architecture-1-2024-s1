# # -- an example to run SPEC 429.mcf on gem5, put it under 429.mcf folder --
# export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
# export BENCHMARK=./src/benchmark
# export ARGUMENT=./data/inp.in

# time $GEM5_DIR/build/RISCV/gem5.opt \
# -d /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/CPUs/MinorCPU/RISCV/SPEC/CacheSize \
# $GEM5_DIR/configs/deprecated/example/se.py \
# -c $BENCHMARK \
# -o $ARGUMENT \
# -I 300000000 \
# --cpu-type=MinorCPU \
# --caches \
# --l2cache \
# --l1d_size=32kB \
# --l1i_size=32kB \
# --l2_size=32kB \
# --l1d_assoc=2 \
# --l1i_assoc=2 \
# --l2_assoc=1 \
# --cacheline_size=64

# Define las variables de entorno
export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
export CACHE_DIR=/CPUs/MinorCPU/RISCV/SPEC/Benchmarks/CacheBM
export CACHE_STATS=/CPUs/MinorCPU/RISCV/SPEC/CacheStats
export BENCHMARK=./src/benchmark
export ARGUMENT=./data/inp.in
# Define y ejecuta para diferentes políticas de reemplazo de caché L2
for CACHE_SIZE in 4kB 16kB 64kB 256kB 1MB; do
    echo "Ejecutando simulación con política de reemplazo: $CACHE_SIZE"
    
    # Ejecuta el benchmark utilizando GEM5
    time $GEM5_DIR/build/RISCV/gem5.opt \
    -d /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$CACHE_DIR \
    $GEM5_DIR/configs/deprecated/example/se.py \
    -c $BENCHMARK \
    -o "$ARGUMENT" \
    -I 300000000 \
    --cpu-type=MinorCPU \
    --caches \
    --l2cache \
    --l1d_size=$CACHE_SIZE \
    --l1i_size=$CACHE_SIZE \
    --l2_size=$CACHE_SIZE \
    --l1d_assoc=2 \
    --l1i_assoc=2 \
    --l2_assoc=1 \
    --cacheline_size=64 \
    
    # Copiar el archivo de estadísticas para identificar claramente cada política # --l2_assoc=1 \    --l1d_assoc=2 \--l1i_assoc=2 \
    cp /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$CACHE_DIR/stats.txt /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$CACHE_STATS/stats_$CACHE_SIZE.txt
done
