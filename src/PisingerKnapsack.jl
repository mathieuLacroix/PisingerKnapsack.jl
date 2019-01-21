__precompile__()

module PisingerKnapsack

using Libdl


const Double = Float64
const depsfile = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsfile)
    include(depsfile)
else
    error("PisingerKnapsack not properly installed. Please run Pkg.build(\"PisingerKnapsack\") then restart Julia.")
end

include("Cwrapper.jl")
include("doubleknp.jl")


export bouknap, minknap, doubleminknap


end # module
