#!/usr/bin/env ruby

class DiskFile
  attr_accessor :size, :id
  def initialize(size, id = nil)
    @size = size
    @id = id
  end

  def to_a()
    a = []
    for _ in 0..(@size-1)
      if @id.nil?
        a << 0
      else
        a << @id
      end
    end
    return a
  end
end

disk = []
disk_map = File.readlines('day9.in', chomp: true)[0].chars.map(&:to_i)

for i in 0..((disk_map.length / 2)-1)
  disk << DiskFile.new(disk_map[i * 2], i)
  disk << DiskFile.new(disk_map[i * 2 + 1])
end
disk << DiskFile.new(disk_map[disk_map.length - 1], disk_map.length / 2)

def print_disk(disk)
  arr = (disk.map { |d| d.to_a }).flatten
  for i in 0..(arr.length-1)
    print "#{arr[i]}, "
  end
  puts
end

def idx_by_id(disk, id)
  return nil unless id.is_a? Integer
  for i in 0..(disk.length-1)
    return i if disk[i].id == id
  end
  return nil
end

end_file = disk_map.length / 2

def defragment_one(disk, end_file)
  idx = idx_by_id(disk, end_file)
  size = disk[idx].size
  for i in 0..(idx-1)
    next unless disk[i].id.nil?
    next if disk[i].size < size
    size_diff = disk[i].size - size
    # if sizes are the same swap, otherwise insert new file
    disk[i].id = end_file
    disk[i].size = size
    disk[idx].id = nil
    disk[idx].size = disk[idx].size
    disk.insert(i+1, DiskFile.new(size_diff, nil)) if size_diff != 0
    break
  end
  return disk
end

while 0 <= end_file do
  disk = defragment_one(disk, end_file)
  end_file -= 1
end

def cksum(disk)
  arr = (disk.map { |d| d.to_a }).flatten
  sum = 0
  for i in 0..(arr.length-1)
    sum += arr[i] * i
  end
  return sum
end

puts cksum(disk)
