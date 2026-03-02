# frozen_string_literal: true

describe "#prime_number?" do
  it "returns true" do
    expect(prime_number?(2)).to eq(true)
    expect(prime_number?(3)).to eq(true)
    expect(prime_number?(5)).to eq(true)
    expect(prime_number?(7)).to eq(true)
  end

  it "returns false" do
    expect(prime_number?(1)).to eq(false)
    expect(prime_number?(4)).to eq(false)
    expect(prime_number?(6)).to eq(false)
    expect(prime_number?(8)).to eq(false)
  end
end

def prime_number?(number)
  return false if number < 2
  return true if number == 2
  return false if number.even?

  # (3..Math.sqrt(n).to_i) -- creates a range from 3 up to the square root of n (converted to integer)
  # .step(2) -- iterates thru that range in steps of 2, skipping even numbers
  # .none? { |i| n % i == 0 } -- checks if n is divisible by any number in the range
  (3..Math.sqrt(number).to_i).step(2).none? { |i| number % i == 0 }
end
