all: run_julia

run_julia:
	OMP_NUM_THREADS=1 julia --project=. benchmark.jl data/rfmm3d_julia_benchmark_1.csv
	OMP_NUM_THREADS=2 julia --project=. benchmark.jl data/rfmm3d_julia_benchmark_2.csv
	OMP_NUM_THREADS=4 julia --project=. benchmark.jl data/rfmm3d_julia_benchmark_4.csv
	OMP_NUM_THREADS=8 julia --project=. benchmark.jl data/rfmm3d_julia_benchmark_8.csv
	OMP_NUM_THREADS=16 julia --project=. benchmark.jl data/rfmm3d_julia_benchmark_16.csv