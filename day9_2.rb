#!/usr/bin/env ruby

disk_map = File.readlines('day9.in', chomp: true)[0].chars.map(&:to_i)

class DiskFile
  attr_accessor :size, :id
  def initialize(size, id = nil)
    @size = size
    @id = id
  end
end

disk = []

for i in 0..(disk_map.length / 2)
  used = disk_map[i * 2]
  free = disk_map[i * 2 + 1]
  disk << DiskFile.new(used, i)
  disk << DiskFile.new(free)
end
disk << DiskFile.new(disk_map[disk_map.length - 1], disk_map.length / 2)
