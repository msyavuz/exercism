defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(context) do
      case context do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: #{context}"}
      end
    end
  end

  def divide(stack) do
    case stack do
      [] ->
        raise StackUnderflowError, "when dividing"

      [_] ->
        raise StackUnderflowError, "when dividing"

      [0 | _tail] ->
        raise DivisionByZeroError

      [head, tail] ->
        tail / head
    end
  end
end
