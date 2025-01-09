#!/usr/bin/env ruby

disk_map = File.readlines('day9.in', chomp: true)[0].chars.map(&:to_i)

def disk_from_map(disk_map)
    disk = []
    i = 0
    while i < (disk_map.length / 2)
      used = disk_map[i * 2]
      free = disk_map[i * 2 + 1]
      for _ in 1..used
        disk << i.to_s.chars[0]
      end
      for _ in 1..free
        disk << '.'
      end
      i += 1
    end
    # Last element doesn't have trailing free space.
    used = disk_map[i * 2]
    for _ in 1..used
      disk << i.to_s.chars[0]
    end
    return disk
end

def print_disk(disk)
  disk.map { |c| print c }
  puts
end

print_disk(disk_from_map(disk_map))
