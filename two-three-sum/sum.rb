require 'set'

# int[] arr
# @return boolean
def two_sum(arr, sum)
  values_visited = Set.new

  arr.each do |value|
    remainder = sum - value
    return true if values_visited.include?(remainder)
    values_visited.add(value)
  end

  false
end

puts "#{two_sum([5, 6, 7, 8, 1, 2, 3, 4], 10)} == true"
puts "#{two_sum([1, 2, 3, 4], 3)} == true"
puts "#{two_sum([1, 3, 8, 5], 10)} == false"
puts "#{two_sum([10, 10], 10)} == false"
puts "#{two_sum([1, 2], 0)} == false"
puts "#{two_sum([], 10)} == false"

### three sum ###

def three_sum(arr, sum)
  arr.sort!

  n = arr.size
  first_index = 0
  while first_index <= n - 3
    first = arr[first_index]
    start_index = first_index + 1
    end_index = n - 1

    while start_index < end_index
      second = arr[start_index]
      third = arr[end_index]

      current_sum = first + second + third
      if current_sum == sum
        # answer found, return
        return true
      elsif current_sum > sum
        # too much, shift upper bound
        end_index -= 1
      else
        # too low, shift lower bound
        start_index += 1
      end
    end

    first_index += 1
  end
  false
end

puts "#{three_sum([5, 6, 7, 8, 1, 2, 3, 4], 18)} == true"
puts "#{three_sum([1, 2, 3, 4], 6)} == true"
puts "#{three_sum([1, 3, 8, 5], 20)} == false"
puts "#{three_sum([10, 10, 10], 10)} == false"
puts "#{three_sum([1, 2, 3], 0)} == false"
puts "#{three_sum([1, 2], 10)} == false"
puts "#{three_sum([], 10)} == false"
