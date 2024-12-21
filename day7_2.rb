#!/usr/bin/env ruby

def concat(a, b)
  return ( a.to_s + b.to_s ).to_i
end

def solve(total, acc, numbers)
  if numbers.empty?
    return acc == total
  end

  x = numbers[0]
  numbers = numbers.drop(1)

  added      = acc + x
  multiplied = acc * x
  concatenated = concat(acc, x)

  do_add = false
  do_multiply = false
  do_concatenate = false

  if added <= total
    do_add = solve(total, added, numbers)
  end

  if multiplied <= total
    do_multiply = solve(total, multiplied, numbers)
  end

  if concatenated <= total
    do_concatenate = solve(total, concatenated, numbers)
  end

  return do_add || do_multiply || do_concatenate
end

result = 0

for line in File.readlines('day7.in', chomp: true)
  numbers = line.sub(/:/, '').split(' ').map(&:to_i)
  total   = numbers[0]
  acc     = numbers[1]
  numbers = numbers.drop(2)
  if solve(total, acc, numbers)
    result += total
  end
end

puts result
