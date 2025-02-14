#!/usr/bin/env ruby

MAT = File.readlines('day6.in', chomp: true).map(&:chars)

$start_x = -1
$start_y = -1
$start_direction = ''

# Find the starting position
for x in 0..MAT.length-1
  for y in 0..MAT[x].length-1
    if MAT[x][y] == '^' || MAT[x][y] == 'v' ||
       MAT[x][y] == '<' || MAT[x][y] == '>'
      $start_x = x
      $start_y = y
      $start_direction = MAT[x][y]
      break
    end
  end
  break if $start_direction != ''
end

WORKING = 0
LOOPED  = 1
EXITED  = 2

class Solver
  def initialize(block_x, block_y)
    @mat = MAT.map(&:dup)
    if block_x != -1 && block_y != -1
      @mat[block_x][block_y] = 'O'
    end
    @x = $start_x
    @y = $start_y
    @direction = $start_direction
    @shadow = MAT.map { |row| row.map { |cell| [] } }
    @shadow[@x][@y] << @direction
    @status = WORKING
  end

  def move()
    x = @x
    y = @y
    case @direction
      when '^'
        x -= 1
      when 'v'
        x += 1
      when '<'
        y -= 1
      when '>'
        y += 1
    end

    return EXITED if x < 0 || y < 0 || x >= @mat.length || y >= @mat[x].length

    if @mat[x][y] == '#' || @mat[x][y] == 'O'
      case @direction
        when '^'
          @direction = '>'
        when 'v'
          @direction = '<'
        when '<'
          @direction = '^'
        when '>'
          @direction = 'v'
      end
      return LOOPED if @shadow[@x][@y].include?(@direction)
      @shadow[@x][@y] << @direction
      return WORKING
    end

    @x = x
    @y = y
    return LOOPED if @shadow[@x][@y].include?(@direction)
    @shadow[@x][@y] << @direction
    return WORKING
  end

  def loop?()
    while @status == WORKING
      @status = move()
    end
    return @status == LOOPED
  end

  def status
    return @status
  end

  def set_status(new_status)
    @status = new_status
  end

  def x
    return @x
  end

  def y
    return @y
  end

  def to_s
    result = ''
    for x in 0..@mat.length-1
      for y in 0..@mat[x].length-1
        if x == $start_x && y == $start_y
          result += $start_direction
        elsif @mat[x][y] == '#' || @mat[x][y] == 'O'
          result += @mat[x][y]
        elsif ( @shadow[x][y].include?('^') || @shadow[x][y].include?('v') ) &&
              ( @shadow[x][y].include?('<') || @shadow[x][y].include?('>') )
          result += '+'
        elsif @shadow[x][y].include?('^') || @shadow[x][y].include?('v')
          result += '|'
        elsif @shadow[x][y].include?('<') || @shadow[x][y].include?('>')
          result += '-'
        else
          result += @mat[x][y]
        end
      end
      result += "\n"
    end
    return result
  end
end

# Find original path
positions = []
base = Solver.new(-1, -1)
while base.status == WORKING
  base.set_status(base.move())
  positions << [base.x, base.y] unless base.status == EXITED
end

loops = 0
for pos in positions.uniq
  solver = Solver.new(pos[0], pos[1])
  loops += 1 if solver.loop?()
end
puts loops
