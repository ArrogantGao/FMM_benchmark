using FMM2D
using LinearAlgebra
using BenchmarkTools
using CSV, DataFrames

function benchmark_rfmm2d(ns::Int)
    sources = rand(2, ns)
    charges = rand(ns)

    time = @belapsed rfmm2d(sources=$(sources),charges=$(charges), eps=1e-4, pg = 2)

	@show ns, time

    return time
end

function main(args::Vector{String})
    filename = args[1]
    df = CSV.write(filename, DataFrame(ns = Int[], time = Float64[]))
    for n in [100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200, 102400, 204800, 409600]
        time = benchmark_rfmm2d(n)
        CSV.write(df, DataFrame(ns = n, time = time), append = true)
    end
    return df
end

main(ARGS)
