
def all_permutations(s)
  return s if s.size == 1
  p = []

  s.size.times do |i|
    tmp = s[i]
    tail = s[0...i] + s[i + 1..-1]

    all_permutations(tail).map do |permutation|
      p << "#{tmp}#{permutation}"
    end
  end

  p
end

puts all_permutations([1, 2, 3, 4, 5])
