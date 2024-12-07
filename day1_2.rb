#!/usr/bin/env ruby

lefts = []
rights = []
File.readlines('day1_2.in', chomp: true).each do |line|
  numbers = line.split.map(&:to_i)
  lefts << numbers[0]
  rights << numbers[1]
end

def pop(rights, number)
  count = 0
  for i in 0..rights.length-1
    if rights[i] == number
        count += 1
    end
  end
  return count
end

similarity = 0
for i in 0..lefts.length-1
  similarity += lefts[i] * pop(rights, lefts[i])
end

puts similarity
