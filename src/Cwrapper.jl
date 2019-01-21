# helper macros/functions
macro pk_min_ccall(func, args...)
    args = map(esc, args)
    f = "$func"
    quote
        ccall(($f, PisingerKnapsack._jl_libminknap), $(args...))
    end
end

macro pk_bou_ccall(func, args...)
    args = map(esc, args)
    f = "$func"
    quote
        ccall(($f, PisingerKnapsack._jl_libbouknap), $(args...))
    end
end

"""
    Solve the integer knapsack problem with upper bounds on the number of copies of each object which can be taken.
    Objective coefficients and weights are integer (Int32).
"""
function bouknap(p::Vector{Cint}, w::Vector{Cint}, ub::Vector{Cint}, capacity::Cint)
    nbitems = length(p)
    solution = fill(Cint(0), nbitems)
    obj = @pk_bou_ccall bouknap Clong (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
            Ptr{Cint}, Cint) nbitems p w ub solution capacity
    return (obj, solution)
end

function bouknap(p::Vector, w::Vector, ub::Vector, capacity)
    return bouknap(convert(Vector{Cint}, p), convert(Vector{Cint}, w), convert(Vector{Cint}, ub), Cint(capacity))
end

"""
    Solve the binary knapsack problem. Objective coefficients and weights are integer (Int32).
"""
function minknap(p::Vector{Cint}, w::Vector{Cint}, capacity::Cint)
    nbitems = length(p)
    solution = fill(Cint(0), nbitems)
    obj = @pk_min_ccall minknap Clong (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint},
            Cint) nbitems p w solution capacity
    return (obj, solution)
end

function minknap(p::Vector, w::Vector, capacity)
    return minknap(convert(Vector{Cint}, p), convert(Vector{Cint}, w), Cint(capacity))
end


