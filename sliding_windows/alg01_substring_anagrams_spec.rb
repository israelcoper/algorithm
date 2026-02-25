# frozen_string_literal: true

describe "#substring_anagrams" do
  describe "an empty string" do
    it "returns zero" do
      expect(substring_anagrams("", "aba")).to eq(0)
    end
  end

  describe "string having no anagrams" do
    it "returns zero" do
      expect(substring_anagrams("abc", "aba")).to eq(0)
    end
  end

  describe "string having anagrams" do
    it "returns anagram count" do
      expect(substring_anagrams("caabab", "aba")).to eq(2)
      expect(substring_anagrams("listen", "silent")).to eq(1)
    end
  end
end

def substring_anagrams(string, anagram)
  string_size, anagram_size = string.size, anagram.size
  return 0 if string_size < anagram_size

  count = 0
  expected_frequency, window_frequency = [0] * 26, [0] * 26

  # Populate `expected_frequency` with the characters in `anagram`
  anagram.chars.each { |char| expected_frequency[char.ord - "a".ord] += 1 }

  left = right = 0
  while right < string_size
    # Add the character at the right pointer to the  `window_frequency` before sliding the window
    window_frequency[string[right].ord - "a".ord] += 1

    # If the window has reached the expected fixed length, advance the left pointer as well
    # as the right pointer to slide the window
    if right - left + 1 == anagram_size
      count += 1 if expected_frequency == window_frequency

      # Remove the character at the left pointer from the `window_frequency`
      # before advancing the left pointer
      window_frequency[string[left].ord - "a".ord] -= 1
      left += 1
    end

    right += 1
  end

  count
end

# string, anagram = "caabab", "aba"

# ["c", "a", "a", "b", "a", "b"]
# first iteration:
# left = 0, right = 0
# right - left + 1
# 0 - 0 + 1 = 1 == 3

# second iteration:
# left = 0, right = 1
# right - left + 1
# 1 - 0 + 1 = 2 == 3

# third iteration:
# left = 0, right = 2
# right - left + 1
# 2 - 0 + 1 = 3 == 3

# fourth iteration:
# left = 1, right = 2
# right - left + 1
# 2 - 1 + 1 = 2 == 3

# fifth iteration:
# left = 1, right = 3
# right - left + 1
# 3 - 1 + 1 = 3 == 3

# sixth iteration:
# left = 2, right = 3
# right - left + 1
# 3 - 2 + 1 = 2 == 3
