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
  attr_accessor :map

  def initialize(map)
    @map = map
  end

  def width
    @map[0].length
  end

  def height
    @map.length
  end

  def print_map
    @map.each { |row| puts row.join(', ') }
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

  def valid?(position)
    (position.row >= 0) && (position.row < height) &&
      (position.column >= 0) && (position.column < width)
  end
end

map = File.readlines('day10.in', chomp: true).map { |l| l.chars.map(&:to_i) }
topo_map = TopoMap.new(map)

topo_map.print_map
