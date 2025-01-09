#!/usr/bin/env ruby

disk_map = File.readlines('day9.in', chomp: true)[0].chars.map(&:to_i)

def disk_from_map(disk_map)
    disk = []
    i = 0
    while i < (disk_map.length / 2)
      used = disk_map[i * 2]
      free = disk_map[i * 2 + 1]
      for _ in 1..used
        disk << i
      end
      for _ in 1..free
        disk << '.'
      end
      i += 1
    end
    # Last element doesn't have trailing free space.
    used = disk_map[i * 2]
    for _ in 1..used
      disk << i
    end
    return disk
end

def print_disk(disk)
  disk.map { |c| print c }
  puts
end

disk = disk_from_map(disk_map)

print_disk(disk)

def cksum(disk)
  sum = 0
  for i in 0..(disk.length-1)
    sum += disk[i] * i if disk[i] != '.'
  end
  return sum
end

puts cksum(disk)

def defragmented(disk)
  saw_dot = false
  for x in disk
    if x == '.'
      saw_dot = true
    elsif saw_dot
      return false
    end
  end
  return true
end

puts defragmented(disk)

def defragment_one(disk)
  return disk if defragmented(disk)
  first_empty = disk.index('.')
  last_used = -1
  for i in 0..(disk.length-1)
    last_used = i if disk[i] != '.'
  end
  disk[first_empty] = disk[last_used]
  disk[last_used] = '.'
  return disk
end

def defragment(disk)
  while ! defragmented(disk)
    disk = defragment_one(disk)
  end
  return disk
end

defragmented_disk = defragment(disk)
print_disk(defragmented_disk)
puts cksum(defragmented_disk)
