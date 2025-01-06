#!/usr/bin/env ruby

MAT = File.readlines('day8.in', chomp: true).map(&:chars)
ants = {}
for r in 0..MAT.length-1
  for c in 0..MAT[r].length-1
    ants[MAT[r][c]] = [] if ants[MAT[r][c]].nil?
    ants[MAT[r][c]] << [r, c] if MAT[r][c] != '.'
  end
end

anodes = MAT.map { |r| r.map { |c| 0 } }
ants.each_value do |positions|
  for a in 0..positions.length-1
    for b in (a+1)..positions.length-1
      diff_r = positions[a][0] - positions[b][0]
      diff_c = positions[a][1] - positions[b][1]

      a_r = positions[a][0] + diff_r
      a_c = positions[a][1] + diff_c
      if a_r >= 0 && a_c >= 0 && a_r < MAT.length && a_c < MAT[a_r].length
        anodes[a_r][a_c] += 1
      end

      b_r = positions[b][0] - diff_r
      b_c = positions[b][1] - diff_c
      if b_r >= 0 && b_c >= 0 && b_r < MAT.length && b_c < MAT[b_r].length
        anodes[b_r][b_c] += 1
      end
    end
  end
end

result = 0
for r in anodes
  for c in r
    result += 1 if c > 0
  end
end

puts result
