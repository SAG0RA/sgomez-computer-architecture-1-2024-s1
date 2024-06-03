# Define las variables de entorno
export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
export BENCHMARK=./src/benchmark
export INPUT_FILE=./data/test.txt
export OUTPUT_FILE=./data/output.txt
export ARGUMENT="1 $INPUT_FILE $OUTPUT_FILE"

# Define y ejecuta para diferentes políticas de reemplazo de caché L2
for L2_REPLACEMENT_POLICY in LFURP LRURP RandomRP; do
    echo "Ejecutando simulación con política de reemplazo: $L2_REPLACEMENT_POLICY"
    
    # Ejecuta el benchmark utilizando GEM5
    time $GEM5_DIR/build/ARM/gem5.opt \
    -d /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/ARM/stats_$L2_REPLACEMENT_POLICY \
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
    --cacheline_size=64 \
    --l2_rp=$L2_REPLACEMENT_POLICY
    
    # Copiar el archivo de estadísticas para identificar claramente cada política
    cp /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/ARM/stats_$L2_REPLACEMENT_POLICY/stats.txt /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/ARM/stats_$L2_REPLACEMENT_POLICY.txt
done
