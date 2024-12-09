#!/usr/bin/env ruby

instructions = File.read('day3.in').chomp
sum = 0
enabled = true
instructions.scan(
  /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
).each do |instruction|
  if instruction == "do()"
    enabled = true
  elsif instruction == "don't()"
    enabled = false
  elsif enabled
    numbers = instruction.scan(/\d{1,3}/).map(&:to_i)
    sum += numbers[0] * numbers[1]
  end
end
puts sum
