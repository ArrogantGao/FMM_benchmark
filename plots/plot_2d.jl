using CSV, DataFrames
using CairoMakie

path_to_data = joinpath(@__DIR__, "../fmm2d/data")

df_fortran_1 = CSV.read(joinpath(path_to_data, "rfmm2d_fortran_benchmark_1.csv"), DataFrame)
df_fortran_2 = CSV.read(joinpath(path_to_data, "rfmm2d_fortran_benchmark_2.csv"), DataFrame)
df_fortran_4 = CSV.read(joinpath(path_to_data, "rfmm2d_fortran_benchmark_4.csv"), DataFrame)
df_fortran_8 = CSV.read(joinpath(path_to_data, "rfmm2d_fortran_benchmark_8.csv"), DataFrame)
df_fortran_16 = CSV.read(joinpath(path_to_data, "rfmm2d_fortran_benchmark_16.csv"), DataFrame)
df_julia_1 = CSV.read(joinpath(path_to_data, "rfmm2d_julia_benchmark_1.csv"), DataFrame)
df_julia_2 = CSV.read(joinpath(path_to_data, "rfmm2d_julia_benchmark_2.csv"), DataFrame)
df_julia_4 = CSV.read(joinpath(path_to_data, "rfmm2d_julia_benchmark_4.csv"), DataFrame)
df_julia_8 = CSV.read(joinpath(path_to_data, "rfmm2d_julia_benchmark_8.csv"), DataFrame)
df_julia_16 = CSV.read(joinpath(path_to_data, "rfmm2d_julia_benchmark_16.csv"), DataFrame)

begin
    fig = Figure(size = (1200, 500), fontsize = 20)
    ax = Axis(fig[1, 1], xlabel = "Number of points", ylabel = "Time (s)", title = "FMM2D Run Time", xscale = log10, yscale = log10)

    scatterlines!(ax, df_fortran_1.ns, df_fortran_1.elapsed, label = "Fortran 1 thread", linewidth = 2, color = :blue)
    scatterlines!(ax, df_fortran_2.ns, df_fortran_2.elapsed, label = "Fortran 2 threads", linewidth = 2, color = :red)
    scatterlines!(ax, df_fortran_4.ns, df_fortran_4.elapsed, label = "Fortran 4 threads", linewidth = 2, color = :green)
    scatterlines!(ax, df_fortran_8.ns, df_fortran_8.elapsed, label = "Fortran 8 threads", linewidth = 2, color = :orange)
    scatterlines!(ax, df_fortran_16.ns, df_fortran_16.elapsed, label = "Fortran 16 threads", linewidth = 2, color = :purple)
    scatterlines!(ax, df_julia_1.ns, df_julia_1.time, label = "Julia 1 thread", linewidth = 2, marker = :diamond, color = :blue)
    scatterlines!(ax, df_julia_2.ns, df_julia_2.time, label = "Julia 2 threads", linewidth = 2, marker = :diamond, color = :red)
    scatterlines!(ax, df_julia_4.ns, df_julia_4.time, label = "Julia 4 threads", linewidth = 2, marker = :diamond, color = :green)
    scatterlines!(ax, df_julia_8.ns, df_julia_8.time, label = "Julia 8 threads", linewidth = 2, marker = :diamond, color = :orange)
    scatterlines!(ax, df_julia_16.ns, df_julia_16.time, label = "Julia 16 threads", linewidth = 2, marker = :diamond, color = :purple)


    ax2 = Axis(fig[1, 2], xlabel = "Number of points", ylabel = "Speedup", title = "FMM2D Speedup", xscale = log10, yscale = log10, yticks = [1, 2, 4, 8, 16])
    scatterlines!(ax2, df_julia_2.ns, df_julia_1.time ./ df_julia_2.time, label = "Julia 2 threads", linewidth = 2, color = :red, marker = :diamond)
    scatterlines!(ax2, df_julia_4.ns, df_julia_1.time ./ df_julia_4.time, label = "Julia 4 threads", linewidth = 2, color = :green, marker = :diamond)
    scatterlines!(ax2, df_julia_8.ns, df_julia_1.time ./ df_julia_8.time, label = "Julia 8 threads", linewidth = 2, color = :orange, marker = :diamond)
    scatterlines!(ax2, df_julia_16.ns, df_julia_1.time ./ df_julia_16.time, label = "Julia 16 threads", linewidth = 2, color = :purple, marker = :diamond)

    scatterlines!(ax2, df_fortran_2.ns, df_fortran_1.elapsed ./ df_fortran_2.elapsed, label = "Fortran 2 threads", linewidth = 2, color = :red)
    scatterlines!(ax2, df_fortran_4.ns, df_fortran_1.elapsed ./ df_fortran_4.elapsed, label = "Fortran 4 threads", linewidth = 2, color = :green)
    scatterlines!(ax2, df_fortran_8.ns, df_fortran_1.elapsed ./ df_fortran_8.elapsed, label = "Fortran 8 threads", linewidth = 2, color = :orange)
    scatterlines!(ax2, df_fortran_16.ns, df_fortran_1.elapsed ./ df_fortran_16.elapsed, label = "Fortran 16 threads", linewidth = 2, color = :purple)

    ylims!(ax2, 1, 8)

    Legend(fig[1, 3], ax, position = :lt, labelsize = 12, nbanks = 1)
    save("benchmark_fmm2d_comparison.svg", fig)
    fig
end