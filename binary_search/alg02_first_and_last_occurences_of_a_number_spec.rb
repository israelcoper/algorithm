# frozen_string: true

describe "#first_and_last_occurences_of_a_number" do
  describe "target is not in the array" do
    it "returns [-1, -1]" do
      expect(first_and_last_occurences_of_a_number([], 0)).to eq([-1, -1])
      expect(first_and_last_occurences_of_a_number([1, 2, 3, 4, 4, 4, 5, 6, 7, 8, 9, 10, 11], 0)).to eq([-1, -1])
    end
  end

  describe "target is in the array" do
    it "returns the indexes" do
      expect(first_and_last_occurences_of_a_number([1, 1], 1)).to eq([0, 1])

      expect(first_and_last_occurences_of_a_number([1, 2, 3, 4, 4, 4, 5, 6, 7, 8, 9, 10, 11], 4)).to eq([3, 5])
      expect(first_and_last_occurences_of_a_number([1, 2, 3, 4, 4, 4, 5, 6, 7, 8, 9, 10, 11], 5)).to eq([6, 6])
    end
  end
end

def first_and_last_occurences_of_a_number(array, target)
  lower_bound = lower_bound_binary_search(array, target)
  upper_bound = upper_bound_binary_search(array, target)

  [lower_bound, upper_bound]
end

def lower_bound_binary_search(array, target)
  left, right = 0, array.length - 1

  while left < right
    mid = (left + right) / 2

    if array[mid] > target
      right = mid - 1
    elsif array[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end

  array && array[left] == target ? left : -1
end

def upper_bound_binary_search(array, target)
  left, right = 0, array.length - 1

  while left < right
    # In upper-bound binary search, bias the midpoint value to the right.
    mid = (left + right) / 2 + 1

    if array[mid] > target
      right = mid - 1
    elsif array[mid] < target
      left = mid + 1
    else
      left = mid
    end
  end

  # If the target doesn't exist in the array, then it's possible that
  # 'left = mid + 1' places the left pointer outside the array when 'mid == n - 1'.
  # So, we use the right pointer in the return statement instead.
  array && array[right] == target ? right : -1
end
