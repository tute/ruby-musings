require "minitest/autorun"
require_relative "knapsack"

describe Knapsack do
  describe '#pack' do
    it 'accepts only items that fit' do
      knapsack = Knapsack.new(size: 11)

      # An items hash has size for keys and
      # worth for values
      items = {
        12 => 25,
        15 => 35,
        18 => 67
      }

      knapsack.pack(items).must_equal 0
    end

    it 'optimizes for item value' do
      knapsack = Knapsack.new(size: 11)

      items = {
        2  => 1,
        5  => 10,
        6  => 20,
        9  => 24,
        11 => 28,
        14 => 36
      }

      other_items = {
        3  => 9,
        12 => 29,
        18 => 14,
        2  => 3
      }

      expected_items = {
        5 => 10,
        6 => 20
      }

      expected_other_items = {
        3 => 9,
        2 => 3
      }

      knapsack.pack(items).must_equal 30
      knapsack.pack(other_items).must_equal 12
    end

    it 'doesn\'t get tricked by value/weight ratios' do
      knapsack = Knapsack.new(size: 5)
      items = {
        2 => 2,
        3 => 3,
        4 => 4.5
      }

      result = knapsack.pack(items)

      result.must_equal 5
    end

    it 'can have empty space' do
      knapsack = Knapsack.new(size: 11)

      items = {
        1 => 8,
        3 => 4
      }

      knapsack.pack(items).must_equal 12
    end
  end
end
