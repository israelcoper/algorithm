# frozen_string_literal: true

describe "#longest_substring_with_unique_characters" do
  describe "an empty string" do
    it "returns zero" do
      expect(longest_substring_with_unique_characters("")).to eq(0)
    end
  end

  describe "string having unique characters" do
    it "returns unique character count" do
      expect(longest_substring_with_unique_characters("abc")).to eq(3)
      expect(longest_substring_with_unique_characters("abcba")).to eq(3)
      expect(longest_substring_with_unique_characters("cabcdeca")).to eq(5)
    end
  end
end

def longest_substring_with_unique_characters(string)
  max_length = 0
  previous_indexes = {}
  left = right = 0

  while right < string.length
    # If the previous index of the current character is present in the current window,
    # it's a duplicate character in the window
    if previous_indexes.has_key?(string[right]) && previous_indexes[string[right]] >= left
      # Shrink the window to exclude the previous occurence of this character
      left = previous_indexes[string[right]] + 1
    end

    # Update max length if the current window is larger
    max_length = [max_length, right - left + 1].max
    previous_indexes[string[right]] = right

    # Expand the window
    right += 1
  end

  max_length
end
