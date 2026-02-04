# frozen_string: true

describe "#find_the_insertion_index" do
  describe "target is in the array" do
    it "returns the index" do
      expect(find_the_insertion_index([1, 2, 4, 5, 7, 8, 9], 4)).to eq(2)
    end
  end

  describe "target is not in the array" do
    it "inserts the target at the correct index" do
      expect(find_the_insertion_index([1, 2, 4, 5, 7, 8, 9], -10)).to eq(0)
      expect(find_the_insertion_index([1, 2, 4, 5, 7, 8, 9], 3)).to eq(2)
      expect(find_the_insertion_index([1, 2, 4, 5, 7, 8, 9], 6)).to eq(4)
      expect(find_the_insertion_index([1, 2, 4, 5, 7, 8, 9], 20)).to eq(7)
    end
  end
end

def find_the_insertion_index(array, target)
  left, right = 0, array.length

  while left < right
    mid = (left + right) / 2

    # If the midpoint value is greater than or equal to the target.
    # the lower bound is either at the midpoint , or to its left.
    if array[mid] >= target
      right = mid
    # The midpoint value is less than the target, indicating the
    # lower bound is somewhere to the right.
    else
      left = mid + 1
    end
  end

  left
end
