# frozen_string_literal: true

describe "#fibonacci" do
  describe "value <= 0" do
    it "returns an empty array" do
      expect(fibonacci(-1)).to eq([])
      expect(fibonacci(0)).to eq([])
    end
  end

  describe "value is 1" do
    it "returns [0]" do
      expect(fibonacci(1)).to eq([0])
    end
  end

  describe "value is 2" do
    it "returns [0, 1]" do
      expect(fibonacci(2)).to eq([0, 1])
    end
  end

  describe "value > 2" do
    it "returns correct fibonacci sequence" do
      expect(fibonacci(3)).to eq([0, 1, 1])
      expect(fibonacci(4)).to eq([0, 1, 1, 2])
      expect(fibonacci(5)).to eq([0, 1, 1, 2, 3])
      expect(fibonacci(6)).to eq([0, 1, 1, 2, 3, 5])
      expect(fibonacci(7)).to eq([0, 1, 1, 2, 3, 5, 8])
      expect(fibonacci(8)).to eq([0, 1, 1, 2, 3, 5, 8, 13])
      expect(fibonacci(9)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21])
      expect(fibonacci(10)).to eq([0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
    end
  end
end

def fibonacci(number)
  return [] if number <= 0
  return [0] if number == 1
  return [0, 1] if number == 2

  sequence = [0, 1]

  (number - 2).times do
    sequence << sequence[-1] + sequence[-2]
  end

  sequence
end
