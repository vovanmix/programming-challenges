# Return the start/end point for the largest contiguous section of free space on the disk.
# Input: [(4, 12), (15, 78), (89, 93)], size=100
# Output: (79, 88)

# Input: [[4, 12], [15, 78], [89, 93]], size=100, removing=[30, 50]
# Output: [30, 50]

# occupied int[][]
# size int
def free_space(old_occupied, size, removing = [])
  return [] if size == 0
  occupied = remove_space(old_occupied, removing)
  
  return [0, size - 1] if occupied.size == 0
  
  max = 0
  free_interval = []
  
  i = 0
  while i < occupied.size - 1
    interval = occupied[i]
    next_interval = occupied[i + 1]
    distance = next_interval[0] - interval[1] - 1
    if distance > max
      max = distance
      free_interval = [interval[1] + 1, next_interval[0] - 1]
    end
    i += 1
  end
  
  end_distance = size - occupied[occupied.size - 1][1] - 1
  if end_distance > max
    max = end_distance
    free_interval = [occupied[occupied.size - 1][1] + 1, size - 1]
  end
  
  free_interval
end

def remove_space(occupied, removing)
  return occupied if removing == []
  i = 0
  new_occupied = []
  while i < occupied.size
    interval = occupied[i]
    if interval[0] <= removing[0] && interval[1] >= removing[1]
      if interval[0] == removing[0]
        interval[0] = removing[1] + 1
        new_occupied << interval if interval[0] < interval[1]
      elsif interval[1] == removing[1]
        interval[1] = removing[0] - 1
        new_occupied << interval
      else
        new_occupied << [interval[0], removing[0] - 1]
        new_occupied << [removing[1] + 1, interval[1]]
      end
    else
      new_occupied << interval
    end
    i += 1
  end
  new_occupied
end


puts "#{free_space([[4, 12], [15, 78], [89, 93]], 100)} == [79, 88]"
puts "#{free_space([[4, 12], [15, 78]], 100)} == [79, 99]"
puts "#{free_space([], 100)} == [0, 99]"
puts "#{free_space([[0,99]], 100)} == []"
puts "#{free_space([[4, 12], [13, 78], [79, 99]], 100)} == []"
puts "#{free_space([[4, 12], [15, 78], [89, 93]], 100, [30, 50])} == [30, 50]"
puts "#{free_space([], 0)} == []"
puts "#{free_space([], 1)} == [0,0]"


puts "#{remove_space([[4, 12], [13, 78], [79, 99]], [13, 40])} == [[4, 12], [41, 78], [79, 99]]"
puts "#{remove_space([[4, 12], [13, 78], [79, 99]], [40, 78])} == [[4, 12], [13, 39], [79, 99]]"
puts "#{remove_space([[4, 12], [13, 78], [79, 99]], [13, 78])} == [[4, 12], [79, 99]]"
puts "#{remove_space([[4, 12], [13, 78], [79, 99]], [40, 50])} == [[4, 12], [13, 39], [51, 78], [79, 99]]"
