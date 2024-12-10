#!/usr/bin/env ruby

mat = []

File.readlines('day4.in', chomp: true).each do |line|
  mat << line.split('')
end

def check(mat, i, j)
  if mat[i][j] != 'A'
    return false
  end
  if i-1 < 0 || j-1 < 0 || i+1 >= mat.length || j+1 >= mat[i].length
    return false
  end

  if mat[i-1][j-1] == 'M' && mat[i+1][j+1] == 'S' &&
     mat[i-1][j+1] == 'M' && mat[i+1][j-1] == 'S'
    return true
  end
  if mat[i-1][j-1] == 'S' && mat[i+1][j+1] == 'M' &&
     mat[i-1][j+1] == 'S' && mat[i+1][j-1] == 'M'
    return true
  end
  if mat[i-1][j-1] == 'M' && mat[i+1][j+1] == 'S' &&
     mat[i-1][j+1] == 'S' && mat[i+1][j-1] == 'M'
    return true
  end
  if mat[i-1][j-1] == 'S' && mat[i+1][j+1] == 'M' &&
     mat[i-1][j+1] == 'M' && mat[i+1][j-1] == 'S'
    return true
  end
  return false
end

count = 0
for i in 1..mat.length-2
  for j in 1..mat[i].length-2
    if check(mat, i, j)
      count += 1
    end
  end
end
puts count
