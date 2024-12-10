#!/usr/bin/env ruby

pairs = []
updates = []
do_updates = false

File.readlines('day5.in', chomp: true).each do |line|
  if line.empty?
    do_updates = true
    next
  end
  if do_updates
    updates << line.split(',').map(&:to_i)
  else
    pairs << line.split('|').map(&:to_i)
  end
end

