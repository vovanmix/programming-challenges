def binary_search(input, num)
  left = 0
  right = input.size - 1

  while left <= right
    mid = ((right - left) / 2) + left

    sample = input[mid]

    return mid if sample == num

    if sample < num
      left = mid + 1
    else
      right = mid - 1
    end
  end

  -1
end

puts "#{binary_search([-4, -2, 1, 4, 7, 9, 12], 9)} == 5"
puts "#{binary_search([-4, -2, 1, 4, 7, 9, 12], 19)} == -1"
puts "#{binary_search([-4, -2, 1, 4, 7, 9, 12], -2)} == 1"
puts "#{binary_search([1, 1, 1, 1, 1], 1)} == 2"
puts "#{binary_search([], 1)} == -1"
