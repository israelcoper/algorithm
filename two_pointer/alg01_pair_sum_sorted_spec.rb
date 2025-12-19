# frozen_string_literal: true

describe "#pair_sum_sorted" do
  describe "an empty array" do
    it "returns an empty array" do
      expect(pair_sum_sorted([], 0)).to eq([])
    end
  end

  describe "an array with just one element" do
    it "returns an empty array" do
      expect(pair_sum_sorted([0], 1)).to eq([])
    end
  end

  describe "a two-element array that contains a pair that sums to the target" do
    it "returns [0, 1]" do
      expect(pair_sum_sorted([2, 3], 5)).to eq([0, 1])
    end
  end

  describe "a two-element array that does'nt contain a pair that sums to the target" do
    it "returns an empty array" do
      expect(pair_sum_sorted([2, 4], 5)).to eq([])
    end
  end

  describe "an array with duplicate values" do
    it "returns [0, 2] or [1, 2]" do
      expect(pair_sum_sorted([2, 2, 3], 5)).to eq([0, 2])
    end
  end

  describe "test if the algo works with negative number in the target pair" do
    it "returns [0, 2]" do
      expect(pair_sum_sorted([-1, 2, 3], 2)).to eq([0, 2])
    end
  end

  describe "test if the algo works with both numbers of the target pair being negative" do
    it "returns [0, 1]" do
      expect(pair_sum_sorted([-3, -2, -1], -5)).to eq([0, 1])
    end
  end
end

def pair_sum_sorted(array, target)
  left, right = 0, array.length - 1
  while left < right
    sum = array[left] + array[right]
    if sum < target
      left += 1
    elsif sum > target
      right -= 1
    else
      return [left, right]
    end
  end

  []
end
