# frozen_string_literal: true

describe "#triplet_sum" do
  describe "an empty array" do
    it "returns an empty array" do
      expect(triplet_sum([])).to eq([])
    end
  end

  describe "a single-element array" do
    it "returns an empty array" do
      expect(triplet_sum([0])).to eq([])
    end
  end

  describe "a two-element array" do
    it "returns an empty array" do
      expect(triplet_sum([1, -1])).to eq([])
    end
  end

  describe "an array where all three of its values are the same" do
    it "returns [0, 0, 0]" do
      expect(triplet_sum([0, 0, 0])).to eq([[0, 0, 0]])
    end
  end

  describe "an array with no triplets that sum to 0" do
    it "returns an empty array" do
      expect(triplet_sum([1, 0, 1])).to eq([])
    end
  end

  describe "an array with duplicate triplets" do
    it "returns [-1, 0, 1]" do
      expect(triplet_sum([0, 0, 1, -1, 1, -1])).to eq([[-1, 0, 1]])
    end
  end
end

# a + b + c = 0
# b + c = -a
def triplet_sum(array)
  triplets = []
  array.sort!

  array.each_with_index do |num, index|
    # Triplets consisting of only positive numbers will never sum to 0
    if array[index] > 0
      break
    end

    # To avoid duplicate triplets, skip 'a' if it is the same as the previous number
    if index > 0 && array[index] == array[index - 1]
      next
    end

    # a = -array[index]
    pairs = pair_sum_sorted_all_pairs(array, -array[index], index + 1)

    pairs.each do |pair|
      # pair consists of [b, c]
      triplets << [array[index]] + pair
    end
  end

  triplets
end

# target = -a
def pair_sum_sorted_all_pairs(array, target, start_index)
  pairs = []
  left, right = start_index, array.length - 1

  while left < right
    sum = array[left] + array[right]
    if sum < target
      left += 1
    elsif sum > target
      right -= 1
    else
      pairs << [array[left], array[right]]
      left += 1

      # To avoid duplicate [b, c] pairs, skip 'b' if it is the same as the previous number
      while left < right && array[left] == array[left - 1]
        left += 1
      end
    end
  end

  pairs
end
