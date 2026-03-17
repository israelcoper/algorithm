# frozen_string_literal: true

describe "#caesar_shift" do
  it "shifts characters by 3 positions" do
    expect(caesar_shift("Hello, world!", 3)).to eq("Khoor, zruog!")
  end

  it "returns the same string when shift is 0" do
    expect(caesar_shift("Hello, world!", 0)).to eq("Hello, world!")
  end

  it "wraps around the alphabet" do
    expect(caesar_shift("Z", 1)).to eq("A")
    expect(caesar_shift("z", 1)).to eq("a")
  end

  it "handles shifts greater than 26" do
    expect(caesar_shift("Hello, world!", 29)).to eq("Khoor, zruog!")
  end

  it "leaves non-alpha characters unchanged" do
    expect(caesar_shift("123!@#", 5)).to eq("123!@#")
  end

  it "returns an empty string when given an empty string" do
    expect(caesar_shift("", 3)).to eq("")
  end
end

describe "#caesar_decrypt" do
  it "decrypts characters shifted by 3 positions" do
    expect(caesar_decrypt("Khoor, zruog!", 3)).to eq("Hello, world!")
  end

  it "is the inverse of caesar_shift" do
    expect(caesar_decrypt(caesar_shift("Hello, world!", 13), 13)).to eq("Hello, world!")
  end
end

module CaesarCipher
  UPPERCASE_ASCII_START = "A".ord
  LOWERCASE_ASCII_START = "a".ord
  ALPHABET_SIZE         = 26

  def caesar_shift(string, shift)
    string.chars.map do |char|
      # Only shift letters
      if char.match?(/[a-zA-Z]/)
        # Base ASCII value:
        # UPPERCASE_ASCII_START ('A') - uppercase letters
        # LOWERCASE_ASCII_START ('a') - lowercase letters
        base = char == char.upcase ? UPPERCASE_ASCII_START : LOWERCASE_ASCII_START

        # Shift char within its case alphabet with wraparound, then convert back to char
        # char.ord  - convert char to ASCII value
        # - base    - normalize to a 0-based index (0-25)
        # + shift   - apply the shift
        # % ALPHABET_SIZE - wraparound if it exceeds 25
        # + base    - convert back to ASCII
        # .chr      - convert ASCII number back to character
        ((char.ord - base + shift) % ALPHABET_SIZE + base).chr
      else
        char
      end
    end.join
  end

  def caesar_decrypt(string, shift)
    caesar_shift(string, -shift)
  end
end

include CaesarCipher
