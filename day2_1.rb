#!/usr/bin/env ruby

def ascending(numbers)
  for i in 0..numbers.length-2
    if numbers[i] > numbers[i+1]
      return false
    end
  end
  return true
end

def descending(numbers)
  for i in 0..numbers.length-2
    if numbers[i] < numbers[i+1]
      return false
    end
  end
  return true
end

def safe_diff(numbers)
  for i in 1..numbers.length-1
    diff = (numbers[i] - numbers[i-1]).abs
    if diff < 1 || diff > 3
      return false
    end
  end
  return true
end

def safe(numbers)
  return safe_diff(numbers) && (ascending(numbers) || descending(numbers))
end

safes = 0

File.readlines('day2.in', chomp: true).each do |line|
  if safe(line.split.map(&:to_i))
    safes += 1
  end
end

puts safes
