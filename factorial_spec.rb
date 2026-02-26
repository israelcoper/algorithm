# frozen_string_literal: true

describe "#factorial" do
  it "returns an error message" do
    expect(factorial(-1)).to eq("Factorial is undefined for negative numbers")
  end

  it "returns the factorial of a number" do
    expect(factorial(0)).to eq(1)
    expect(factorial(1)).to eq(1)
    expect(factorial(2)).to eq(2)
    expect(factorial(3)).to eq(6)
    expect(factorial(4)).to eq(24)
  end
end

def factorial(n)
  raise ArgumentError, "Factorial is undefined for negative numbers" if n < 0
  return 1 if n == 0

  (1..n).inject(:*)
rescue ArgumentError => e
  e.message
end
