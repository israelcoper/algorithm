# frozen_string: true

describe "#next_largest_number_to_the_right" do
  describe "an empty array" do
    it "returns an empty array" do
      expect(next_largest_number_to_the_right([])).to eq([])
    end
  end

  describe "a non-empty array" do
    it "returns the next largest number to the right" do
      expect(next_largest_number_to_the_right([1, 3, 2, 4])).to eq([3, 4, 4, -1])
      expect(next_largest_number_to_the_right([5, 2, 4, 6, 1])).to eq([6, 4, 6, -1, -1])
      expect(next_largest_number_to_the_right([1, 1, 2, 3, 2, 3, 2, 4])).to eq([2, 2, 3, 4, 3, 4, 4, -1])
    end
  end
end

def next_largest_number_to_the_right(array)
  result = [0] * array.length
  stack = []

  # Find the next largest number of each element, starting with the rightmost element.
  (array.length - 1).downto(0) do |i|
    # Pop values from the top of the stack until the currrent value's nect largest number is at the top.
    while !stack.empty? && stack[-1] <= array[i]
      stack.pop
    end

    # Record the current value's next largest number, which is at the top of the stack.
    # If the stack is empty, record -1.
    result[i] = stack.empty? ? -1 : stack[-1]
    stack << array[i]
  end

  result
end
