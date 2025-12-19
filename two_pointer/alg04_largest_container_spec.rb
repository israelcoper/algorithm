# frozen_string_literal: true

# [2, 7, 8, 3, 7, 6]

#   ^
# 8 |        |
# 7 |     |  |     |
# 6 |     |  |     |  |
# 5 |     |  |     |  |
# 4 |     |  |     |  |
# 3 |     |  |  |  |  |
# 2 |  |  |  |  |  |  |
# 1 |  |  |  |  |  |  |
# 0 |  |  |  |  |  |  |
#   -------------------->
#      0  1  2  3  4  5

describe "#largest_container" do
  describe "an empty array" do
    it "returns 0" do
      expect(largest_container([])).to eq(0)
    end
  end

  describe "an array with just one element" do
    it "returns 0" do
      expect(largest_container([1])).to eq(0)
    end
  end

  describe "an array with no container that can contain water" do
    it "returns 0" do
      expect(largest_container([0, 1, 0])).to eq(0)
    end
  end

  describe "an array where all heights are the same" do
    it "returns 9" do
      expect(largest_container([3, 3, 3, 3])).to eq(9)
    end
  end

  describe "an array with strictly increasing heights" do
    it "returns 2" do
      expect(largest_container([1, 2, 3])).to eq(2)
    end
  end

  describe "an array with strictly decreasing heights" do
    it "returns 2" do
      expect(largest_container([3, 2, 1])).to eq(2)
    end
  end
end

# Formula for area of a container:
# min(height[left], height[right]) * (right - left)
def largest_container(heights)
  left, right = 0, heights.length - 1
  max_water = 0

  while left < right
    # Calculate the water contained between the current pair of lines.
    water = [heights[left], heights[right]].min * (right - left)
    max_water = [max_water, water].max

    # Move the pointers inward, always moving the pointer at he shorter line.
    # If both lines have the same height, move both pointers inward.
    if heights[left] < heights[right]
      left += 1
    elsif heights[left] > heights[right]
      right -= 1
    else
      left += 1
      right -= 1
    end
  end

  max_water
end
