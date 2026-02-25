# frozen_string_literal: true

#   ^
# 9 |
# 8 |          |
# 7 |          |
# 6 |    |     |
# 5 |    |     |
# 4 |    |     |
# 3 |    |  |  |
# 2 | |  |  |  |
# 1 | |  |  |  |
# 0 -------------------------->
#     2  6  3  8

describe "#cutting_wood" do
  describe "when the input array is empty" do
    it do
      expect(cutting_wood([], 7)).to eq(0)
    end
  end

  describe "when the required wood amount exceeds what's available" do
    it do
      expect(cutting_wood([2, 6, 3, 8], 100)).to eq(0)
    end
  end

  describe "when a valid cutting height exists to obtain the required wood" do
    it "returns the maximum height that yields at least the required wood" do
      expect(cutting_wood([2, 6, 3, 8], 7)).to eq(3)
    end
  end
end

# k, represents the total lenght of wood that needs to be cut.
def cutting_wood(heights, k)
  left, right = 0, heights.length

  while left < right
    # Bias the midpoint to the right during the upper-bound binary search.
    mid = (left + right) / 2 + 1

    if cuts_enough_wood(mid, k, heights)
      left = mid
    else
      right = mid - 1
    end
  end

  right
end

# h is the highest possible setting for the height of the cut.
# Determine if the current value of 'h' cuts at least 'k' meters of wood.
def cuts_enough_wood(h, k, heights)
  wood_collected = 0

  heights.each do |height|
    if height > h
      wood_collected += height - h
    end
  end

  wood_collected >= k
end
