# 1 
function taylor_exp(n::Int64, x::T) where T
    a0 = one(T)
    res = a0
    for i in 1:n-1
        a0 *= x / (i+1)
        res += a0
    end
    return res

end

println(taylor_exp(20, 0.5))

# 2 
function machine_precision()
    eps = Float64(0.5)^52
    while (1.0 + eps) > 1.0
        eps /= 2.0
    end
    return eps
end

println(machine_precision())

# 4 
function gaussian_elimination(A::AbstractMatrix{T}, b::AbstractVector{T})::AbstractVector{T} where T
    @assert size(A, 1) == size(A, 2)
    n = size(A, 1) 
    x = zeros(T, n)

    for i in n:-1:1
        x[i] = b[i]
        for j in i+1:n
            x[i] =fma(-x[j] ,A[i,j] , x[i])
        end
        x[i] /= A[i,i]
    end
    return x
end

# 8 
function rang(A)
    gaussian_elimination!(copy(A))

    # Вычисляем ранг матрицы A как количество ненулевых строк
    count = 0; i = 1
       # check = zeros(t, 0)
        while A[i, i] != 0.0
            count = count + 1
            i += 1
        end
    return count
end


A = [1.0 2.0 4.0 2.0; 3.0 5.0 2.0 11.0; 2.0 6.0 7.0 9.0]

println(gaussian_elimination(A))