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

rules = {}

for pair in pairs
  if rules.has_key?(pair[1])
    rules[pair[1]] << pair[0]
  else
    rules[pair[1]] = [pair[0]]
  end
end

def is_valid(rules, update)
  bads = []
  for x in update
    if bads.include?(x)
      return false
    end
    if rules.has_key?(x)
      bads += rules[x]
    end
  end
  return true
end

sum = 0
for update in updates
  if is_valid(rules, update)
    sum += update[(update.length/2).floor]
  end
end
puts sum
