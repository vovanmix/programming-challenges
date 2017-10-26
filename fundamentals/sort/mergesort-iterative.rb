# int[] nums
# @return int[]
def merge_sort(nums)
  steps = 1
  while steps < nums.size

    left = 0
    while left < nums.size
      mid = left + steps
      right = [left + 2 * steps, nums.size].min

      combine(nums, left, mid, right)

      left += 2 * steps
    end

    steps *= 2
  end
  nums
end

# int[] nums
# int left
# int mid
# int right
# @return void
def combine(nums, left, mid, right)
  left_index = left
  right_index = mid
  res = []

  while left_index < mid && right_index < right
    if nums[left_index] <= nums[right_index]
      res << nums[left_index]
      left_index += 1
    else
      res << nums[right_index]
      right_index += 1
    end
  end

  while left_index < mid
    res << nums[left_index]
    left_index += 1
  end

  while right_index < right
    res << nums[right_index]
    right_index += 1
  end

  i = 0
  while i + left < right
    nums[i + left] = res[i]
    i += 1
  end
end

puts "#{merge_sort([3, 2, 1, -5])} == [-5, 1, 2, 3]"
puts "#{merge_sort([1, -2, -3])} == [-3, -2, 1]"
puts "#{merge_sort([2, 4, 1, 5, 3, 7, 2, 4, 6])} == [1, 2, 2, 3, 4, 4, 5, 6, 7]"
puts "#{merge_sort([1, 2, 3])} == [1, 2, 3]"
puts "#{merge_sort([1, 1, 1])} == [1, 1, 1]"
puts "#{merge_sort([2])} == [2]"
puts "#{merge_sort([])} == []"
