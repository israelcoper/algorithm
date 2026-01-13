# frozen_string_literal: true

describe "#pair_sum_unsorted" do
  describe "an empty array" do
    it "returns an empty array" do
      expect(pair_sum_unsorted([], 0)).to eq([])
    end
  end

  describe "an array with just one element" do
    it "returns an empty array" do
      expect(pair_sum_unsorted([0], 1)).to eq([])
    end
  end

  describe "a two-element array that contains a pair that sums to the target" do
    it "returns [0, 1]" do
      expect(pair_sum_unsorted([2, 3], 5)).to eq([0, 1])
    end
  end

  describe "a two-element array that does'nt contain a pair that sums to the target" do
    it "returns an empty array" do
      expect(pair_sum_unsorted([2, 4], 5)).to eq([])
    end
  end

  describe "an array with duplicate values" do
    it "returns [1, 2]" do
      # 2 => 0
      # 2 => 1
      # 3 => 2
      expect(pair_sum_unsorted([2, 2, 3], 5)).to eq([1, 2])
    end
  end

  describe "test if the algo works with negative number in the target pair" do
    it "returns [0, 2]" do
      expect(pair_sum_unsorted([-1, 2, 3], 2)).to eq([0, 2])
    end
  end

  describe "test if the algo works with both numbers of the target pair being negative" do
    it "returns [0, 1]" do
      expect(pair_sum_unsorted([-3, -2, -1], -5)).to eq([0, 1])
    end
  end

  describe "test if the algo works with unsorted array" do
    it "returns [-1, 3, 4, 2]" do
      expect(pair_sum_unsorted([-1, 3, 4, 2], 3)).to eq([0, 2])
    end
  end
end

# x + y = target
# y = target - x
# y is the complement
def pair_sum_unsorted(array, target)
  hash = {}

  array.each_with_index do |x, i|
    y = target - x
    return [hash[y], i] if hash.key?(y)

    hash[x] = i
  end

  []
end
