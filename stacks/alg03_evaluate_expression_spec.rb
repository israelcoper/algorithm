# frozen_string_literal: true

describe "#evaluate_expression" do
  describe "an empty string" do
    it "returns 0" do
      expect(evaluate_expression("")).to eq(0)
    end
  end

  describe "a non-empty string" do
    it "returns the result of evaluating the expression" do
      expect(evaluate_expression("18-(7+(2-4))")).to eq(13)
      expect(evaluate_expression("(1+(4+5+2)-3)+(6+8)")).to eq(23)
    end
  end
end

def evaluate_expression(expression)
  stack = []
  current_number, sign, result = 0, 1, 0
  expression.each_char do |char|
    if char.match?(/\d/)
      current_number = current_number * 10 + char.to_i
    # If the current character is an operator, add the current number to the result
    # after multiplying it by its sign.
    elsif char == "+" || char == "-"
      result  += current_number * sign

      # Update the sign and reset the current number.
      sign = char == "-" ? -1 : 1
      current_number = 0
    # If the current character is a an opening parenthesis, a new nested expression is starting.
    elsif char == "("
      # Save the current result and sign values by pushing them onto the stack,
      # then reset their values to start calculating the new nested expression.
      stack << result
      stack << sign

      result, sign = 0, 1
    # If the current character is a closing parenthesis, a nested expression has ended.
    elsif char == ")"
      # Finalize the result of the current nested expression.
      result += current_number * sign

      # Apply the sign of the current nested expression's result before adding this result
      # to the result of the outer expression.
      result *= stack.pop
      result += stack.pop

      current_number = 0
    end
  end

  # Finalize the result of the overall expression.
  result + current_number * sign
end
