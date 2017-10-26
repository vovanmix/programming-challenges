# int[] nums
# @return int[]
def merge_sort(nums)
  if nums.size <= 1
    nums
  elsif nums.size == 2
    if nums[0] > nums[1]
      [nums[1], nums[0]]
    else
      nums
    end
  else
    left, right = split_array_in_half(nums)
    combine(merge_sort(left), merge_sort(right))
  end
end

def split_array_in_half(nums)
  mid = nums.size / 2
  [
    nums[0...mid],
    nums[mid..-1]
  ]
end

# int[] left
# int[] right
# @return int[]
def combine(left, right)
  left_index = 0
  right_index = 0
  res = []

  while left_index < left.size || right_index < right.size
    if left[left_index] && (right[right_index].nil? || left[left_index] <= right[right_index])
      res << left[left_index]
      left_index += 1
    else
      res << right[right_index]
      right_index += 1
    end
  end
  res
end

puts "#{merge_sort([2, 4, 1, 5, 3, 7, 2, 4, 6])} == [1, 2, 2, 3, 4, 4, 5, 6, 7]"
puts "#{merge_sort([1, 2, 3])} == [1, 2, 3]"
puts "#{merge_sort([1, 1, 1])} == [1, 1, 1]"
puts "#{merge_sort([2])} == [2]"
puts "#{merge_sort([])} == []"
