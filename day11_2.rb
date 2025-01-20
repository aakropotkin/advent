#! /usr/bin/env ruby

# frozen_string_literal: true

def split_integer(int)
  as_str = int.to_s
  return [int] if as_str.length.odd?

  left_s = as_str[0..(as_str.length / 2) - 1]
  right_s = as_str[(as_str.length / 2)..(as_str.length - 1)]
  [left_s.to_i, right_s.to_i]
end

MEMO = {}
def expand(stone, times)
  return 1 if times.zero?

  return MEMO[[stone, times]] if MEMO.key?([stone, times])

  if stone.zero?
    result = expand(1, times - 1)
  elsif stone.to_s.length.even?
    split = split_integer(stone)
    result = expand(split[0], times - 1) + expand(split[1], times - 1)
  else
    result = expand(stone * 2024, times - 1)
  end
  MEMO[[stone, times]] = result
  result
end

stones = File.readlines('day11.in', chomp: true)[0].split(' ').map(&:to_i)
puts (stones.sum { |stone| expand(stone, 75) })
