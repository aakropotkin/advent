#! /usr/bin/env ruby

# frozen_string_literal: true

def split_integer(int)
  as_str = int.to_s
  return [int] if as_str.length.odd?

  left_s = as_str[0..(as_str.length / 2) - 1]
  right_s = as_str[(as_str.length / 2)..(as_str.length - 1)]
  [left_s.to_i, right_s.to_i]
end

def process(int)
  return [1] if int.zero?

  return split_integer(int) if int.to_s.length.even?

  [int * 2024]
end

def blink(stones)
  (stones.map { |stone| process(stone) }).flatten
end

stones = File.readlines('day11.in', chomp: true)[0].split(' ').map(&:to_i)
25.times { stones = blink(stones) }
puts stones.length
