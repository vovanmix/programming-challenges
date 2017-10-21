# int[] arr
# @return int
def rotation_point(arr)
  head = arr[0]
  left_index = 0
  right_index = arr.size - 1

  while left_index <= right_index
    middle = left_index + (right_index - left_index).ceil

    # case: rotation is to the right
    if head < arr[middle]
      left_index = middle + 1
    # case: rotation is to the left
    else
      right_index = middle - 1
    end
  end
  right_index + 1 >= arr.size ? 0 : right_index + 1
end

puts "#{rotation_point([5, 6, 7, 8, 1, 2, 3, 4])} == 4"
puts "#{rotation_point([8, 9, 10, 11, 1, 2, 3, 4, 5, 6, 7])} == 4"
puts "#{rotation_point([3, 4, 5, 6, 7, 1, 2])} == 5"
puts "#{rotation_point([1, 2, 3, 4])} == 0"
