#!/usr/bin/env ruby
# @param {Integer[][]} costs
# @return {Integer}
def min_cost(costs)
  return 0 if costs.empty?

  sum = costs[0]
  # for each house
  (1...costs.size).each do |i|
    # for each color
    new_sum = []
    (0...costs[i].size).each do |j|
      min = 2 ** 32 / 2 - 1
      (0...sum.size).each do |k|
        min = [sum[k], min].min if k != j
      end
      new_sum[j] = min + costs[i][j]
    end
    sum = new_sum
  end
  sum.min
end

puts min_cost([[3, 5, 3], [6, 17, 6], [7, 13, 18], [9, 10, 18]])
