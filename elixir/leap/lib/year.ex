defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    divisible_by_four = rem(year, 4) == 0
    divisible_by_hundred = rem(year, 100) == 0
    divisible_by_four_hundred = rem(year, 400) == 0

    (divisible_by_four and not divisible_by_hundred) or divisible_by_four_hundred
  end
end
