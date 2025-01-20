#! /usr/bin/env ruby

# frozen_string_literal: true

def split_integer(int)
  as_str = int.to_s
  return [int] if as_str.length.odd?

  mid = as_str.length / 2
  [as_str[0...mid].to_i, as_str[mid..].to_i]
end

MEMO = {}

def expand(stone, times)
  return 1 if times.zero?
  return MEMO[[stone, times]] if MEMO[[stone, times]]

  MEMO[[stone, times]] =
    if stone.zero?
      expand(1, times - 1)
    elsif stone.to_s.length.even?
      split = split_integer(stone)
      expand(split[0], times - 1) + expand(split[1], times - 1)
    else
      expand(stone * 2024, times - 1)
    end
end

stones = File.read('day11.in', chomp: true).split.map(&:to_i)
puts stones.sum { |stone| expand(stone, 75) }
