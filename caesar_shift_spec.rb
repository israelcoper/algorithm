# frozen_string_literal: true

describe "#caesar_shift" do
  it "shifts the characters in the string" do
    expect(caesar_shift("Hello, world!", 3)).to eq("Khoor, zruog!")
  end
end

describe "#caesar_decrypt" do
  it "decrypts the characters in the string" do
    expect(caesar_decrypt("Khoor, zruog!", 3)).to eq("Hello, world!")
  end
end

def caesar_shift(string, shift)
  string.chars.map do |char|
    # Only shift letters
    if char.match?(/[a-zA-Z]/)
      # Base ASCII value:
      # 65 ('A') - 90 ('Z') for uppercase
      # 97 ('a') - 122 ('z') for lowercase
      base = char.ord < 91 ? 65 : 97

      # Shift char within its case alphabet with wraparound, then convert back to char
      # char.ord  - convert char to ASCII value
      # - base    - normalize to a 0-based index (0-25)
      # + shift   - apply the shift
      # % 26      - wraparound if it exceeds 25
      # + base    - convert back to ASCII
      # .chr      - convert ASCII number back to character
      ((char.ord - base + shift) % 26 + base).chr
    else
      char
    end
  end.join
end

def caesar_decrypt(string, shift)
  caesar_shift(string, -shift)
end
