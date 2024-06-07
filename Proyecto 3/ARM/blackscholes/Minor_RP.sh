export GEM5_DIR=/home/saul/Desktop/Sims/GEM5/gem5/
export RP_DIR=/CPUs/MinorCPU/ARM/PARSEC/Benchmarks/RPBM
export RP_STATS=/CPUs/MinorCPU/ARM/PARSEC/RPStats

export BENCHMARK=./src/benchmark
export INPUT_FILE=./data/test.txt
export OUTPUT_FILE=./data/output.txt
export ARGUMENT="1 $INPUT_FILE $OUTPUT_FILE"

# Define y ejecuta para diferentes políticas de reemplazo de caché L2
for RP in LRURP LFURP FIFORP MRURP RandomRP; do
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
    --l1d_size=4kB \
    --l1i_size=4kB \
    --l2_size=16kB \
    --cacheline_size=64 \
    --l2_rp=$RP
    
    # Copiar el archivo de estadísticas para identificar claramente cada política # --l2_assoc=1 \    --l1d_assoc=2 \--l1i_assoc=2 \
    cp /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$RP_DIR/stats.txt /home/saul/Desktop/Proyectos/sgomez-computer-architecture-1-2024-s1/Proyecto\ 3/$RP_STATS/stats_$RP.txt
done