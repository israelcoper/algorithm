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

  describe "an expression with multiplication and division" do
    it "returns the result of evaluating the expression" do
      expect(evaluate_expression("2*(5+5*2)/3")).to eq(10)
    end
  end
end

# Evaluates a math expression string (supports +, -, *, /, parentheses).
#
# Key idea: scan left to right, resolving each number as soon as we hit the
# *next* operator. Store resolved values in a stack and sum at the end.
# * and / are applied immediately (higher precedence); + and - just push onto
# the stack (deferred) so they all get added up together at the end.
# Parentheses save/restore the current stack so the inner result becomes a
# single number passed back to the outer expression.
def evaluate_expression(expression)
  return 0 if expression.empty?

  context_stack = [] # saves outer scope when entering parentheses
  local_stack = []   # holds resolved operand values for the current scope
  number = 0         # builds up multi-digit numbers digit by digit
  operator = "+"     # implicit leading '+' so the first number is pushed as-is

  # Push the completed number onto local_stack, applying the pending operator.
  # + and - defer (push positive/negative); * and / resolve immediately.
  apply = lambda do |n|
    case operator
    when "+" then local_stack.push(n)
    when "-" then local_stack.push(-n)
    when "*" then local_stack.push(local_stack.pop * n)
    when "/" then local_stack.push(local_stack.pop / n)
    end
  end

  expression.each_char do |char|
    if char.match?(/\d/)
      number = number * 10 + char.to_i  # accumulate digits into a full number
    elsif char == "("
      # Pause the outer scope and start fresh inside the parentheses.
      context_stack.push([local_stack, operator])
      local_stack = []
      operator = "+"
      number = 0
    elsif char == ")"
      # Wrap up the inner scope: flush last number, sum it, restore outer scope.
      apply.call(number)
      sub_result = local_stack.sum
      local_stack, operator = context_stack.pop
      number = sub_result  # treat the whole sub-expression as one number
    elsif char.match?(/[+\-*\/]/)
      apply.call(number)  # the previous number is complete; apply it
      operator = char
      number = 0
    end
  end

  apply.call(number) # flush the last number (no trailing operator in the loop)
  local_stack.sum
end
