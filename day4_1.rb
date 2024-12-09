#!/usr/bin/env ruby

mat = []

File.readlines('day4.in', chomp: true).each do |line|
  mat << line.split('')
end

def check_right(mat, i, j)
  if j+3 >= mat[i].length
    return false
  end
  return mat[i][j] == 'X' && mat[i][j+1] == 'M' &&
         mat[i][j+2] == 'A' && mat[i][j+3] == 'S'
end

def check_down(mat, i, j)
  if i+3 >= mat.length
    return false
  end
  return mat[i][j] == 'X' && mat[i+1][j] == 'M' &&
         mat[i+2][j] == 'A' && mat[i+3][j] == 'S'
end

def check_left(mat, i, j)
  if j-3 < 0
    return false
  end
  return mat[i][j] == 'X' && mat[i][j-1] == 'M' &&
         mat[i][j-2] == 'A' && mat[i][j-3] == 'S'
end

def check_up(mat, i, j)
  if i-3 < 0
    return false
  end
  return mat[i][j] == 'X' && mat[i-1][j] == 'M' &&
         mat[i-2][j] == 'A' && mat[i-3][j] == 'S'
end

def check_ne(mat, i, j)
  if i-3 < 0 || j+3 >= mat[i].length
    return false
  end
  return mat[i][j] == 'X' && mat[i-1][j+1] == 'M' &&
         mat[i-2][j+2] == 'A' && mat[i-3][j+3] == 'S'
end

def check_se(mat, i, j)
  if i+3 >= mat.length || j+3 >= mat[i].length
    return false
  end
  return mat[i][j] == 'X' && mat[i+1][j+1] == 'M' &&
         mat[i+2][j+2] == 'A' && mat[i+3][j+3] == 'S'
end

def check_sw(mat, i, j)
  if i+3 >= mat.length || j-3 < 0
    return false
  end
  return mat[i][j] == 'X' && mat[i+1][j-1] == 'M' &&
         mat[i+2][j-2] == 'A' && mat[i+3][j-3] == 'S'
end

def check_nw(mat, i, j)
  if i-3 < 0 || j-3 < 0
    return false
  end
  return mat[i][j] == 'X' && mat[i-1][j-1] == 'M' &&
         mat[i-2][j-2] == 'A' && mat[i-3][j-3] == 'S'
end

matches = 0

for i in 0..mat.length-1
  for j in 0..mat[i].length-1
    if mat[i][j] != 'X'
      next
    end
    if check_right(mat, i, j)
      matches += 1
    end
    if check_down(mat, i, j)
      matches += 1
    end
    if check_left(mat, i, j)
      matches += 1
    end
    if check_up(mat, i, j)
      matches += 1
    end
    if check_ne(mat, i, j)
      matches += 1
    end
    if check_se(mat, i, j)
      matches += 1
    end
    if check_sw(mat, i, j)
      matches += 1
    end
    if check_nw(mat, i, j)
      matches += 1
    end
  end
end

puts matches
