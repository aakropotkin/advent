#!/usr/bin/env ruby

lefts = []
rights = []
File.readlines('day1_1.in', chomp: true).each do |line|
  numbers = line.split.map(&:to_i)
  lefts << numbers[0]
  rights << numbers[1]
end

lefts.sort!
rights.sort!

distance = 0
for i in 0..lefts.length-1
  distance += (rights[i] - lefts[i]).abs
end
puts distance
