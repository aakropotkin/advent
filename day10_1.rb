#!/usr/bin/env ruby

class TopoMap
  attr_accessor :map

  def initialize(map)
    @map = map
  end  # def initialize

  def width()
    return @map[0].length
  end

  def height()
    return @map.length
  end

  def print_map()
    for i in 0..(self.height()-1)
      first = true
      for j in 0..(self.width()-1)
        if first
          first = false
        else
          print ", "
        end
        print @map[i][j].to_s
      end
      puts
    end
  end  # def print_map
end  # class TopoMap

map = File.readlines('day10.in', chomp: true).map { |l| l.chars.map(&:to_i) }
topo_map = TopoMap.new(map)

topo_map.print_map
