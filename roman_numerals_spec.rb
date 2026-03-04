# frozen_string_literal: true

describe "#to_roman" do
  it "converts an integer to a roman numeral" do
    expect(RomanNumerals.to_roman(9)).to eq("IX")
    expect(RomanNumerals.to_roman(10)).to eq("X")
    expect(RomanNumerals.to_roman(58)).to eq("LVIII")
    expect(RomanNumerals.to_roman(2024)).to eq("MMXXIV")
  end
end

describe "#to_integer" do
  it "converts a roman numeral to an integer" do
    expect(RomanNumerals.to_integer("IX")).to eq(9)
    expect(RomanNumerals.to_integer("X")).to eq(10)
    expect(RomanNumerals.to_integer("LVIII")).to eq(58)
    expect(RomanNumerals.to_integer("MMXXIV")).to eq(2024)
  end
end

module RomanNumerals
  ROMAN_TO_INT_MAP = [
    ['M',  1000], ['CM', 900], ['D',  500], ['CD', 400],
    ['C',   100], ['XC',  90], ['L',   50], ['XL',  40],
    ['X',    10], ['IX',   9], ['V',    5], ['IV',   4],
    ['I',    1]
  ].freeze

  def self.to_integer(roman)
    result = 0
    remaining = roman.upcase

    # Iterate through numerals from largest to smallest, greedily consuming
    # matching prefixes and accumulating their values. For example, "LVIII":
    #   L -> result=50, remaining="VIII"
    #   V -> result=55, remaining="III"
    #   I -> result=56, remaining="II" -> result=57, remaining="I" -> result=58, remaining=""
    ROMAN_TO_INT_MAP.each do |numeral, value|
      while remaining.start_with?(numeral)
        result += value
        remaining = remaining[numeral.length..] # skip past the matched numeral (endless range = "to end of string")
      end
    end

    result
  end

  def self.to_roman(integer)
    raise ArgumentError, "Must be between 1 and 3999" unless (1..3999).cover?(integer)

    result = ""
    remaining = integer

    # For each numeral (largest first), keep appending it to result and
    # subtracting its value until the remainder is too small to fit. Example, 58:
    #   L(50) -> result="L", remaining=8
    #   V(5)  -> result="LV", remaining=3
    #   I(1)  -> result="LVI", remaining=2 -> result="LVII", remaining=1 -> result="LVIII", remaining=0
    ROMAN_TO_INT_MAP.each do |numeral, value|
      while remaining >= value
        result += numeral
        remaining -= value
      end
    end

    result
  end
end
