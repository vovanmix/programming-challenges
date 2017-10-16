def z_string(string)
  z = []
  l = 0
  r = 0

  k = 1
  while k < string.size
    if k > r
      z[k], l, r = compute_z_explicitly(string, k)
    else
      start = k - l
      if z[start] < r - k + 1
        z[k] = z[start]
      else
        z[k], l, r = compute_z_explicitly(string, k)
      end
    end
    k += 1
  end
  z
end

def compute_z_explicitly(string, idx)
  cnt = 0
  i = 0
  j = idx
  while string[i] == string[j]
    cnt += 1
    i += 1
    j += 1
  end
  [cnt, idx, idx + i - 1]
end

def find_pattern(pattern, string)
  z = z_string(pattern + '$' + string)[pattern.size + 1..-1]
  z.size.times.select { |i| z[i] == pattern.size }
end

puts find_pattern('aab', 'aabcaabxaaaz').to_s
