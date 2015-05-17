require "matrix"

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @matrix = matrix
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    if valid? && incomplete?
      "This sudoku is valid, but incomplete."
    elsif valid?
      "This sudoku is valid."
    else
      "This sudoku is invalid."
    end
  end

  private

  attr_reader :puzzle_string, :matrix

  def matrix
    arrays = puzzle_string.split("\n").map { |row| row.split(" ") }
    arrays.delete_if { |row| row.first =~ /----/ }
    arrays.map { |row| row.map { |cell| cell.gsub!("|", "") } }
    Matrix[ *arrays ]
  end

  def incomplete?
    matrix.to_a.flatten.any? { |el| el == "0" }
  end

  def valid?
    no_repetitions_in_rows? &&
      no_repetitions_in_columns? &&
      no_repetitions_in_subgroups?
  end

  def no_repetitions_in_rows?
    no_repetitions_in? matrix.to_a
  end

  def no_repetitions_in_columns?
    no_repetitions_in? matrix.transpose.to_a
  end

  def no_repetitions_in_subgroups?
    minor_indexes = [(0..2), (3..5), (6..8)]
    minor_indexes.all? do |a_b|
      minor_indexes.all? do |c_d|
        no_repetitions_in? [matrix.minor(a_b, c_d).to_a.flatten]
      end
    end
  end

  def no_repetitions_in?(arrays)
    arrays.all? do |array|
      completed_array = array.reject { |el| el == "0" }
      completed_array.size == completed_array.uniq.size
    end
  end
end
