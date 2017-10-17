def get_max_profit(prices)
  raise IndexError, 'Getting a profit requires at least 2 prices' if prices.size < 2

  min = prices[0]
  max_diff = prices[1] - prices[0]

  for i in (1...prices.size)
    diff = prices[i] - min
    max_diff = [diff, max_diff].max

    min = [prices[i], min].min
  end

  max_diff
end

######## testing: ########

cases = [
  [10, 7, 5, 8, 11, 9],
  [],
  [11],
  [11, 12],
  [10, 10, 10, 10],
  [10, 7, 5, 4, 3, 2]
]

cases.each do |c|
  begin
    puts get_max_profit(c)
  rescue => e
    puts e.message
  end
end
