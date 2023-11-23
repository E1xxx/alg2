#1
function insert_sort!(array::AbstractVector{T})::AbstractVector{T} where T <: Number
    n = 1
    # Инвариант: срез array[1:n] - отсортирован

    while n < length(array) 
        n += 1
        i = n

        while i > 1 && array[i-1] > array[i]
            array[i], array[i-1] = array[i-1], array[i]
            i -= 1
        end

        # Утверждение: array[1] <= ... <= array[n]
    end

    return array
end

insert_sort(array::AbstractVector)::AbstractVector = insert_sort!(copy(array))

#2
function rascheska(arr)
    step = length(arr)
    shrink = 1.247
   while step >=1 
        for i in 1:length(arr) - step
            if arr[i] > arr[i+step]
                arr[i], arr[i+step] = arr[i+step], arr[i]
            end
        end
        step = Int(floor(step/shrink))
   end
    return arr
end

arr = [2, 1, 5, 4, 3, 2, 7, 2, 8, 9]
print(rascheska(arr))

#3
function shell_sort!(arr)
    len = length(arr)   
    step = div(len, 2)          

    while step >= 1
        for i in 1:len - step       
            compare!(arr,i,i + step)
        end
        step = div(step, 2)
    end
    return arr
end

function compare!(arr, i, g)
    if i < 0 || g < 0 
        return;
    end
    if arr[i] > arr[g]
        arr[i], arr[g] = arr[g], arr[i]
        compare!(arr, i, 2i - g)
    end
end

arr = [1, 1, 5, 4, 3, 2, 7, 2, 8, 9]    
print(shell_sort!(arr))

#6
function median(array::AbstractVector{T})::T where T <: Number
	quick_sort!(array)

    if len(array) % 2 == 1
        return array[len(array) / 2]
    else
        return 0.5 * (array[len(array) / 2 - 1] + l[len(array) / 2])
	end
end

#7
function calc_sort!(array::AbstractVector{T})::AbstractVector{T} where T <: Number
    min_val, max_val = extrema(array)
    num_val = zeros(T, max_val - min_val + 1) # - число всех возможных значений

    for val in array
        num_val[val-min_val+1] += 1
    end  
    k = 0

    for (i, num) in enumerate(num_val)
        array[k+1:k+num] .= min_val+i-1
        k += num
    end

    return array
end