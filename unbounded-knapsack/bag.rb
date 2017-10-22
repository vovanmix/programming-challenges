### THE UNBOUNDED KNAPSACK PROBLEM

# int[] products
# int weight_limit
# @return int
def max_weight_value(products, weight_limit)
  weight_index = {}
  products.each do |p|
    next if p[1] == 0
    return Float::INFINITY if p[0] == 0
    weight_index[p[0]] = 0 unless weight_index.key?(p[0])
    weight_index[p[0]] = [weight_index[p[0]], p[1]].max
  end

  max_value_at_weight = []

  weight = 1
  while weight <= weight_limit
    options = []

    options << weight_index[weight] if weight_index.key?(weight)

    other_weight = 1
    # we build current value from the all combinations of best values of
    # all weights below this weight, if both values are present
    # 5 = 4 + 1, 3 + 2, 2 + 3, 1 + 4
    while other_weight < weight
      remaining_weight = weight - other_weight
      if max_value_at_weight[other_weight] && max_value_at_weight[remaining_weight]
        options << max_value_at_weight[other_weight] + max_value_at_weight[remaining_weight]
      elsif max_value_at_weight[other_weight]
        # if no pair value is present, compare with just the weight's value
        options << max_value_at_weight[other_weight]
      end
      other_weight += 1
    end

    max_value_at_weight[weight] = options.max

    weight += 1
  end

  max_value_at_weight[weight_limit] || 0
end

puts "#{max_weight_value([[1, 30], [2, 3], [3, 50], [4, 60], [5, 200]], 10)} == 400"
puts "#{max_weight_value([[1, 30], [50, 200]], 50)} == 1500"
puts "#{max_weight_value([[3, 40], [5, 70]], 8)} == 110"
puts "#{max_weight_value([[3, 40], [5, 70]], 9)} == 120"
puts "#{max_weight_value([[1, 0], [5, 70]], 9)} == 70"
puts "#{max_weight_value([[3, 40], [5, 70]], 0)} == 0"
