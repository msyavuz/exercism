defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """

  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0) do
    0
  end

  def egg_count(number) do
    rem(number, 2) + egg_count(div(number, 2))
  end
end
