#!/usr/bin/env ruby

instructions = File.read('day3.in').chomp
sum = 0
instructions.scan(/mul\(\d{1,3},\d{1,3}\)/).each do |instruction|
  numbers = instruction.scan(/\d{1,3}/).map(&:to_i)
  sum += numbers[0] * numbers[1]
end
puts sum
