def iterative_fib(n)
  raise Exception, 'Index was negative' if n < 0
  return 0 if n == 0
  return 1 if n == 1

  current_index = 2
  number1 = 0
  number2 = 1
  while current_index <= n
    tmp = number2
    number2 = number1 + number2
    number1 = tmp

    current_index += 1
  end
  number2
end

puts "#{iterative_fib(0)} == 0"
puts "#{iterative_fib(1)} == 1"
puts "#{iterative_fib(2)} == 1"
puts "#{iterative_fib(3)} == 2"
puts "#{iterative_fib(4)} == 3"
puts "#{iterative_fib(5)} == 5"
puts "#{iterative_fib(6)} == 8"
puts "#{iterative_fib(7)} == 13"
puts "#{iterative_fib(8)} == 21"
puts "#{iterative_fib(9)} == 34"
puts "#{iterative_fib(10)} == 55"
puts "#{iterative_fib(11)} == 89"
puts "#{iterative_fib(12)} == 144"
