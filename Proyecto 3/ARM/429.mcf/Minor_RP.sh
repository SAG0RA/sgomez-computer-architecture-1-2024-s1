export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
export RP_DIR=/CPUs/MinorCPU/ARM/SPEC/Benchmarks/RPBM
export RP_STATS=/CPUs/MinorCPU/ARM/SPEC/RPStats
export BENCHMARK=./src/benchmark
export ARGUMENT=./data/inp.in
# Define y ejecuta para diferentes políticas de reemplazo de caché L2
for RP in MRURP; do
    echo "Ejecutando simulación con política de reemplazo: $RP"
    
    # Ejecuta el benchmark utilizando GEM5
    time $GEM5_DIR/build/ARM/gem5.opt \
    -d /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$RP_DIR \
    $GEM5_DIR/configs/deprecated/example/se.py \
    -c $BENCHMARK \
    -o "$ARGUMENT" \
    -I 300000000 \
    --cpu-type=MinorCPU \
    --caches \
    --l2cache \
    --l1d_size=16kB \
    --l1i_size=16kB \
    --l2_size=32kB \
    --cacheline_size=64 \
    --l2_rp=$RP
    
    # Copiar el archivo de estadísticas para identificar claramente cada política # --l2_assoc=1 \    --l1d_assoc=2 \--l1i_assoc=2 \
    cp /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$RP_DIR/stats.txt /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$RP_STATS/stats_$RP.txt
done