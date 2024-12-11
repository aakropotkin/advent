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

# KEY Must appear after all VALUES
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


invalids = []
for update in updates
  if !is_valid(rules, update)
    invalids << update
  end
end

fixeds = []
for update in invalids
  fixed = []
  for x in update
    if fixed.empty?
      fixed << x
    else
      for i in 0..fixed.length
        maybe = fixed.dup
        maybe.insert(i, x)
        if is_valid(rules, maybe)
          fixed = maybe
          break
        end
      end
    end
  end
  fixeds << fixed
end

sum = 0
for update in fixeds
  sum += update[(update.length/2).floor]
end
puts sum
