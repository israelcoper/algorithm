# frozen_string_literal: true

describe "#find_the_target_in_a_rotated_sorted_array" do
  describe "target is not in the array" do
    it "returns -1" do
      expect(find_the_target_in_a_rotated_sorted_array([], 0)).to eq(-1)
      expect(find_the_target_in_a_rotated_sorted_array([8, 9, 1, 2, 3, 4, 5, 6, 7], 0)).to eq(-1)
    end
  end

  describe "target is in the array" do
    it "returns the index" do
      expect(find_the_target_in_a_rotated_sorted_array([8, 9, 1, 2, 3, 4, 5, 6, 7], 1)).to eq(2)
    end
  end
end

def find_the_target_in_a_rotated_sorted_array(array, target)
  left, right = 0, array.length - 1

  while left < right
    mid = (left + right) / 2

    if array[mid] == target
      return mid
    # If the left subarray [left : mid] is sorted, check the target falls in this range.
    # If it does, search the left subarray. Otherwise, search the right.
    elsif array[left] <= array[mid]
      if array[left] <= target && target < array[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    # If the right subarray [mid : right] is sorted, check if the target falls in this range.
    # If it does, search the right subarray. Otherwise, search the left.
    else
      if array[mid] < target && target <= array[right]
        left = mid + 1
      else
        right = mid - 1
      end
    end
  end

  # If the target is found in the array, return its index. Otherwise, return -1.
  array && array[left] == target ? left : -1
end
