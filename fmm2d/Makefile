all: install run

install:
	g++ -O3 fmm2d.cpp -L. -lfmm2d -lgfortran -fopenmp -o rfmm2d_fortran_benchmark

clean:
	rm -f rfmm2d_fortran_benchmark

run:
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=1 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_1.csv
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=2 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_2.csv
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=4 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_4.csv
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=8 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_8.csv
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=16 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_16.csv
	LD_LIBRARY_PATH=. OMP_NUM_THREADS=32 ./rfmm2d_fortran_benchmark rfmm2d_fortran_benchmark_32.csv

run_julia:
	OMP_NUM_THREADS=1 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_1.csv
	OMP_NUM_THREADS=2 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_2.csv
	OMP_NUM_THREADS=4 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_4.csv
	OMP_NUM_THREADS=8 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_8.csv
	OMP_NUM_THREADS=16 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_16.csv
	OMP_NUM_THREADS=32 julia --project=. rfmm2d_benchmark.jl rfmm2d_julia_benchmark_32.csv