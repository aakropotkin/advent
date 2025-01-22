#! /usr/bin/env ruby

# frozen_string_literal: true

# A class to represent a position on a map
class Position
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def ==(other)
    @row == other.row && @column == other.column
  end

  def to_s
    "(#{@row}, #{@column})"
  end

  def to_a
    [@row, @column]
  end
end

$max_row = 0
$max_column = 0

# A connected region of points on a map
class Region
  attr_accessor :positions, :letter

  def initialize(letter, positions)
    @positions = positions
    @letter = letter
  end

  def area
    @positions.length
  end

  def neighbors(position)
    neighbors = []
    try = Position.new(position.row - 1, position.column)
    neighbors << try if try.row >= 0 && @positions.include?(try)
    try = Position.new(position.row + 1, position.column)
    neighbors << try if try.row < $max_row && @positions.include?(try)
    try = Position.new(position.row, position.column - 1)
    neighbors << try if try.column >= 0 && @positions.include?(try)
    try = Position.new(position.row, position.column + 1)
    neighbors << try if try.column < $max_column && @positions.include?(try)
    neighbors
  end

  #private :neighbors

  def perimeter
    perimeter = 0
    @positions.each do |position|
      perimeter += 4 - neighbors(position).length
    end
    perimeter
  end

  def cost
    area * perimeter
  end
end

$map = File.readlines('day12.in', chomp: true).map(&:chars)
$max_row = $map.length
$max_column = $map[0].length

def collect_region(letter, position)
  return [] if position.row.negative? || position.row >= $max_row ||
               position.column.negative? || position.column >= $max_column ||
               $map[position.row][position.column] != letter

  $map[position.row][position.column] = ' '
  positions = [position]
  positions += collect_region(letter,
                              Position.new(position.row - 1, position.column))
  positions += collect_region(letter,
                              Position.new(position.row + 1, position.column))
  positions += collect_region(letter,
                              Position.new(position.row, position.column - 1))
  positions += collect_region(letter,
                              Position.new(position.row, position.column + 1))
  positions.uniq
end

regions = []

(0..$max_row - 1).each do |i|
  (0..$max_column - 1).each do |j|
    next if $map[i][j] == ' '

    regions << Region.new($map[i][j],
                          collect_region($map[i][j], Position.new(i, j)))
  end
end

puts regions.sum(&:cost)
