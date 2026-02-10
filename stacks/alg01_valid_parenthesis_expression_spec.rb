# frozen_string: true

describe "#valid_parenthesis_expression" do
  describe "has no valid parenthesis expression" do
    it "returns false" do
      expect(valid_parenthesis_expression("([]{)}")).to eq(false)
    end
  end

  describe "has valid parenthesis expression" do
    it "returns true" do
      expect(valid_parenthesis_expression("([]{})")).to eq(true)
      expect(valid_parenthesis_expression("(){}[]")).to eq(true)
    end
  end
end

def valid_parenthesis_expression(string)
  hash = { '(' => ')', '[' => ']', '{' => '}' }
  stack = []

  string.each_char do |char|
    # If the current character is an opening parenthesis, push it onto the stack.
    if hash.keys.include?(char)
      stack << char
    # If the current character is a closing parenthesis,
    # check if it closes the opening parenthesis at the top of the stack.
    else
      if stack && hash[stack[-1]] == char
        stack.pop
      else
        return false
      end
    end
  end

  # If the stack is empty, all opening parenthesis were successfully closed.
  stack.empty?
end
