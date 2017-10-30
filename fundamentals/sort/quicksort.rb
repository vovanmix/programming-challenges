# int[] input
# @return void
def quicksort(input, left = nil, right = nil)
  if left.nil?
    # input = input.shuffle
    left = 0
    right = input.size - 1
  end

  return if left >= right

  pivot_idx = partition(input, left, right)
  quicksort(input, left, pivot_idx - 1)
  quicksort(input, pivot_idx + 1, right)
end

# @return int
def partition(input, left, right)
  pivot = input[right]

  i = left
  j = left
  while j < right
    if input[j] <= pivot
      swap(input, i, j)
      i += 1
    end

    j += 1
  end
  swap(input, i, right)
  i
end

def swap(input, i, j)
  $swaps += 1
  input[i], input[j] = input[j], input[i] if i != j
end

a = [1, 2, 3, 4, 6, 8]
$swaps = 0
quicksort(a)
puts "#{a} == [1, 2, 3, 4, 6, 8]"
puts "swaps: #{$swaps}" # 20

a = [3, 6, 1, 8, 4, 2]
$swaps = 0
quicksort(a)
puts "#{a} == [1, 2, 3, 4, 6, 8]"
puts "swaps: #{$swaps}" # 7
