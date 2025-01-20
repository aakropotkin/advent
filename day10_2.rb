#!/usr/bin/env ruby

# frozen_string_literal: true

# A class to represent a position on a map
class Position
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def to_s
    "(#{@row}, #{@column})"
  end

  def to_a
    [@row, @column]
  end
end

# A topographical map
class TopoMap
  attr_accessor :map, :scores

  def initialize(map)
    @map = map.map(&:dup)
    @scores = map.map { |row| row.map { 0 } }
    process_scores
  end

  def width
    @map[0].length
  end

  def height
    @map.length
  end

  def print_map
    @map.each { |row| puts row.join('') }
  end

  def trailheads
    trailheads = []
    (0..(height - 1)).each do |i|
      (0..(width - 1)).each do |j|
        trailheads << Position.new(i, j) if @map[i][j].zero?
      end
    end
    trailheads
  end

  def trailends
    trailends = []
    (0..(self.height - 1)).each do |i|
      (0..(self.width - 1)).each do |j|
        trailends << Position.new(i, j) if @map[i][j] == 9
      end
    end
    trailends
  end

  private :trailends

  def valid?(position)
    (position.row >= 0) && (position.row < height) &&
      (position.column >= 0) && (position.column < width)
  end

  def prevs(position)
    positions = []
    return positions unless valid?(position)

    want = @map[position.row][position.column] - 1
    return positions if want < 0

    try = Position.new(position.row - 1, position.column)
    positions << try if valid?(try) && @map[try.row][try.column] == want
    try = Position.new(position.row + 1, position.column)
    positions << try if valid?(try) && @map[try.row][try.column] == want
    try = Position.new(position.row, position.column - 1)
    positions << try if valid?(try) && @map[try.row][try.column] == want
    try = Position.new(position.row, position.column + 1)
    positions << try if valid?(try) && @map[try.row][try.column] == want
    positions
  end

  private :prevs

  def process_score(position)
    if @map[position.row][position.column].zero?
      @scores[position.row][position.column] += 1
    else
      prevs(position).each { |pos| process_score(pos) }
    end
  end

  private :process_score

  def process_scores
    trailends.each { |position| process_score(position) }
    @processed = true
  end

  private :process_scores

  def scores_sum
    sum = 0
    trailheads.each { |position| sum += @scores[position.row][position.column] }
    sum
  end
end

map = File.readlines('day10.in', chomp: true).map { |l| l.chars.map(&:to_i) }
topo_map = TopoMap.new(map)

topo_map.print_map
puts topo_map.scores_sum
