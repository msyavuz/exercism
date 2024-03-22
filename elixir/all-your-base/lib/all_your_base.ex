defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, input_base, _output_base) when input_base <= 1,
    do: {:error, "input base must be >= 2"}

  def convert(_digits, _input_base, output_base) when output_base <= 1,
    do: {:error, "output base must be >= 2"}

  def convert(digits, input_base, output_base) do
    cond do
      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        {:ok,
         digits
         |> Enum.reverse()
         |> Enum.with_index()
         |> Enum.reduce(0, fn {elem, index}, acc ->
           acc + Integer.pow(input_base, index) * elem
         end)
         |> Integer.digits(output_base)}
    end
  end
end
