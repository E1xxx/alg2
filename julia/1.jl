# 1 
function gcd_(a::T, b::T) where T<:Integer
    while !iszero(b)
        a, b = b, a % b
    end
    return abs(a)
end

#2 
function extended_gcd(a::Int, b::Int)
    if b == 0
        return (a, 1, 0)
    else
        d, x, y = extended_gcd(b, rem(a, b))
        return (d, y, x - div(a, b) * y)
    end
end

#3
function invmod_(a::T, M::T) where T
    d, x, y = extended_gcd(a, M)
    if d == 1
        return rem(x, M)
    else
        return nothing
    end
end

#4 
function Diophantine_solve(a, b, c)
    d = gcd_(a, b)
    if c % d != 0
        return nothing
    end
    
    a_d, x0, y0 = gcd_(a, b)
    x = x0 * (c ÷ d)
    y = y0 * (c ÷ d)
    
    return x, y
end

print(Diophantine_solve(14,29,3))

#6
struct Polynom{T}
    coeffs::Vector{T}

    function Polynom(coeffs::Vector{T}) where {T<:Number}
        while length(coeffs) > 1 && coeffs[end] == zero(T)
            pop!(coeffs)
        end
        return new{T}(coeffs)
    end
end

p = Polynom([1, 2, 3])
