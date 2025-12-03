using CSV, DataFrames, Plots

df_fortran_1 = CSV.read("data/rfmm2d_fortran_benchmark_1.csv", DataFrame)
df_fortran_2 = CSV.read("data/rfmm2d_fortran_benchmark_2.csv", DataFrame)
df_fortran_4 = CSV.read("data/rfmm2d_fortran_benchmark_4.csv", DataFrame)
df_fortran_8 = CSV.read("data/rfmm2d_fortran_benchmark_8.csv", DataFrame)
df_fortran_16 = CSV.read("data/rfmm2d_fortran_benchmark_16.csv", DataFrame)

df_julia_1 = CSV.read("data/rfmm2d_julia_benchmark_1.csv", DataFrame)
df_julia_2 = CSV.read("data/rfmm2d_julia_benchmark_2.csv", DataFrame)
df_julia_4 = CSV.read("data/rfmm2d_julia_benchmark_4.csv", DataFrame)
df_julia_8 = CSV.read("data/rfmm2d_julia_benchmark_8.csv", DataFrame)
df_julia_16 = CSV.read("data/rfmm2d_julia_benchmark_16.csv", DataFrame)

begin
    plot(df_fortran_1.ns, df_fortran_1.elapsed, label="Fortran 1", xlabel="Number of sources", ylabel="Time (s)", title="RFMM2D Benchmark", yscale=:log10, xscale=:log10)
    plot!(df_fortran_2.ns, df_fortran_2.elapsed, label="Fortran 2")
    plot!(df_fortran_4.ns, df_fortran_4.elapsed, label="Fortran 4")
    plot!(df_fortran_8.ns, df_fortran_8.elapsed, label="Fortran 8")
    plot!(df_fortran_16.ns, df_fortran_16.elapsed, label="Fortran 16")
    plot!(df_julia_1.ns, df_julia_1.time, label="Julia 1")
    plot!(df_julia_2.ns, df_julia_2.time, label="Julia 2")
    plot!(df_julia_4.ns, df_julia_4.time, label="Julia 4")
    plot!(df_julia_8.ns, df_julia_8.time, label="Julia 8")
    plot!(df_julia_16.ns, df_julia_16.time, label="Julia 16")
end
savefig("rfmm2d_benchmark.svg")