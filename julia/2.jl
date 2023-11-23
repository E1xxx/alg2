#1
function fastpow(a, n)
    k=n
    p=a
    t=1
    while k>0
        if iseven(k)
            k /= 2 
            p *= p
        else
            k -= 1 
            t *= p 
        end
    end
    return t
end

#2
function FibMat(n)
    m = [1 1; 1 0]
    m = fastpow(m,n)
    return m[1,1]
end

print(FibMat(9))

#3
function log(a0, x, epsilon)
    a = a0; flag  = false
    if a < 1.0
        a = 1.0 / a
        flag = true
    end
    y = 0.0; z = x; t = 1.0;
    while abs(t) > epsilon || z < 1.0 / a || z > a
        # инвариант a^y * z^t == x
        if z > a
            z /= a
            y += t
        elseif  z < 1.0 / a
            z *= a
            y -= t
        else
            z *= z
            t /= 2.0
        end
    end

    return (flag) ? -y : y
end

print(log(0.2,15.67,1e-8))

#4
function otr(f::Function, a, b, epsilon)
    f_a = f(a)
    while (b - a > epsilon)
        t = (a + b)/2
        f_t = f(t)
        if (f_t == 0)
            return t
        elseif (f_t * f_a < 0)
            b = t
        else
            a, f_a = t, f_t
        end
    end
    return (a+b) / 2
end

#f(x)=0
function f(x)
    return x * x - 3 * x
end

print(otr(f, -1, 2, 0.01))

#5
function otr_cos(f::Function, a, b, epsilon)
    x0 = a; x1 = b; 
    @assert f(x0) * f(x1) <= 0
    while abs(x0 - x1) > epsilon
        c = (x0 + x1) / 2   # Середина отрезка
        if f(x0) * f(c) < 0
            x1 = c
        else
            @assert f(c) * f(x1) <= 0
            x0 = c
        end
    end
    return (x0 + x1) / 2
end

function F(x)
    return cos(x) - x
end


print(otr_cos(F,-1,3.5,1e-8))

#6
function newton(r::Function, x, epsilon; num_max = 10)
    dx = -r(x)
    k=0
    while abs(dx) > epsilon && k <= num_max
        x += dx
        k += 1
    end
    k > num_max && @warn("Требуемая точность не достигнута")
    return x
end
f(x) = cos(x) - x   
r(x) = f(x)/(sin(x)+1)
println(newton(f,1,1))

#8
struct Polynomials{k}
    coeffs::Vector{k}
    Polynomials{k}(coeffs::Vector{k})  where k = new(coeffs)
end

function Gorner(n::Int, a::T, t) where T
    i = 2
    while (i <= n)
        a[i] = a[i] + a[i-1]*t 
        i = i + 1;
    end
    pop!(a)
    return a
end

p(x) = 6*x^5 - 23*x^4 + 12*x^2 + 86

rp(x) = p(x) / (30*x^4 - 92*x^3 + 24*x)

println(newton(x->x+0,1,1))
println(Gorner(3, [1,2,1], -1))