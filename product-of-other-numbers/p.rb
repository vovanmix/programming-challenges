### Solution 1: pre-indexing

def build_index(arr)
    i = arr.size - 1
    product = 1
    store = {}
    while i >= 0
        product *= arr[i]
        store[i] = product
        i -= 1
    end
    store[arr.size] = 1
    return store
end

def solve(arr)
    if arr.length < 2
        raise IndexError, 'Getting the product of numbers at other indices requires at least 2 numbers'
    end
    
    store = build_index(arr)
    i = 0
    product = 1
    ans = []
    while i < arr.size
        ans[i] = product * store[i + 1]
        product *= arr[i]
        i += 1
    end
    return ans
end

puts solve([1, 2, 6, 5, 9]).to_s
puts solve([0,0,0]).to_s
puts solve([1]).to_s


### Solution 2: recursion

def after_index(idx, arr, store)
    return store[idx] if store.key?(idx)
    return 1 if idx >= arr.size

    store[idx] = after_index(idx + 1, arr, store) * arr[idx]
    return store[idx]
end

def solve(arr)
    store = {}
    i = 0
    product = 1
    ans = []
    while i < arr.size
        ans[i] = product * after_index(i + 1, arr, store)
        product *= arr[i]
        i += 1
    end
    return ans
end

arr = [1, 2, 6, 5, 9]

puts solve(arr).to_s
