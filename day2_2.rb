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
  numbers = line.split.map(&:to_i)
  if safe(numbers)
    safes += 1
  else
    for i in 0..numbers.length-1
      drop1 = numbers.dup
      drop1.delete_at(i)
        if safe(drop1)
            safes += 1
            break
        end
    end
  end
end

puts safes
