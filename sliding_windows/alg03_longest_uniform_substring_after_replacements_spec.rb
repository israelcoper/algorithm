# frozen_string: true

describe "#longest_uniform_substring_after_replacements" do
  describe "an empty string" do
    it "returns zero" do
      expect(longest_uniform_substring_after_replacements("", 2)).to eq(0)
    end
  end

  describe "string having replacements" do
    it "returns longest uniform substring" do
      expect(longest_uniform_substring_after_replacements("aabcdcca", 2)).to eq(5)
    end
  end
end

def longest_uniform_substring_after_replacements(string, max_replacements)
  frequency = {}
  highest_frequency = max_length = 0
  left = right = 0

  while right < string.length
    # Update the frequency of the character at the right pointer
    # and the highest frequency for the current window.
    frequency[string[right]] = frequency.fetch(string[right], 0) + 1
    highest_frequency = [highest_frequency, frequency[string[right]]].max
    # Calculate replacements needed for the current window.
    num_chars_to_replace = (right - left + 1) - highest_frequency

    # Slide the window if the number of replacements needed exceeds `max_replacements`.
    # The right pointer is always gets advanced, so we just need to advance the left pointer
    if num_chars_to_replace > max_replacements
      # Remove the character at the left pointer from the hash map
      # before advancing the left pointer.
      frequency[string[left]] -= 1
      left += 1
    end

    # Since the length of the current window increases or stays the same,
    # assign the length of the current window to `max_length`.
    max_length = right - left + 1
    # Expand the window.
    right += 1
  end

  max_length
end
