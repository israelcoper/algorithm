# frozen_string_literal: true

describe "#palidrome?" do
  describe "nil" do
    it "returns false" do
      expect(palidrome?).to eq(false)
    end
  end

  describe "an empty string" do
    it "returns true" do
      expect(palidrome?("")).to eq(true)
    end
  end

  describe "a single-character string" do
    it "returns true" do
      expect(palidrome?("a")).to eq(true)
    end
  end

  describe "a palidrome with two characters" do
    it "returns true" do
      expect(palidrome?("aa")).to eq(true)
    end
  end

  describe "a non-palidrome with two characters" do
    it "returns false" do
      expect(palidrome?("ab")).to eq(false)
    end
  end

  describe "a string with no alphanumeric characters" do
    it "returns true" do
      expect(palidrome?("!, (?)")).to eq(true)
    end
  end

  describe "a palindrome with punctuation and numbers" do
    it "returns true" do
      expect(palidrome?("12.02.2021")).to eq(true)
    end
  end

  describe "a non-palindrome with punctuation and numbers" do
    it "returns false" do
      expect(palidrome?("21.02.2021")).to eq(false)
    end
  end

  describe "a non-palindrome with punctuation" do
    it "returns false" do
      expect(palidrome?("hello, world!")).to eq(false)
    end
  end

  describe "valid palindrome" do
    it "returns true" do
      expect(palidrome?("racecar")).to eq(true)
      expect(palidrome?("A man, a plan, a canal: Panama")).to eq(true)
      expect(palidrome?("A dog, a panic in a pagoda.")).to eq(true)
    end
  end
end

def palidrome?(string = nil)
  return false if string.nil?

  array = string.chars.map(&:downcase)
  left, right = 0, array.length - 1
  while left < right
    while left < right && !array[left].match?(/\A[a-zA-Z0-9]\z/)
      left += 1
    end

    while left < right && !array[right].match?(/\A[a-zA-Z0-9]\z/)
      right -= 1
    end

    return false if array[left] != array[right]

    left += 1
    right -= 1
  end

  true
end
