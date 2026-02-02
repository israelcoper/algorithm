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
    frequency[string[right]] = frequency.fetch(string[right], 0) + 1
    highest_frequency = [highest_frequency, frequency[string[right]]].max
    num_chars_to_replace = (right - left + 1) - highest_frequency

    if num_chars_to_replace > max_replacements
      frequency[string[left]] -= 1
      left += 1
    end

    max_length = right - left + 1
    right += 1
  end

  max_length
end
