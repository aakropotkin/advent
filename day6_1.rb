#!/usr/bin/env ruby

MAT = File.readlines('day6.in', chomp: true).map(&:chars)
$shadow = MAT.map(&:dup)

$x = 0
$y = 0
$direction = ''

# Find the starting position
for i in 0..MAT.length-1
  for j in 0..MAT[i].length-1
    if MAT[i][j] == '^' || MAT[i][j] == 'v' ||
       MAT[i][j] == '<' || MAT[i][j] == '>'
      $x = i
      $y = j
      $direction = MAT[i][j]
      break
    end
  end
  break if $direction != ''
end

$shadow[$x][$y] = 'X'

def move()
  x = $x
  y = $y
  case $direction
    when '^'
      x -= 1
    when 'v'
      x += 1
    when '<'
      y -= 1
    when '>'
      y += 1
  end
  if x < 0 || y < 0 || x >= MAT.length || y >= MAT[x].length
    return true
  end
  if MAT[x][y] == '#'
    case $direction
      when '^'
        $direction = '>'
      when 'v'
        $direction = '<'
      when '<'
        $direction = '^'
      when '>'
        $direction = 'v'
    end
    return false
  end
  $x = x
  $y = y
  $shadow[$x][$y] = 'X'
  return false
end

while !move()
end

visited = 0
for x in 0..$shadow.length-1
  for y in 0..$shadow[x].length-1
    if $shadow[x][y] == 'X'
      visited += 1
    end
  end
end

puts visited
