defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance_to_center = :math.sqrt(x * x + y * y)

    cond do
      distance_to_center <= 1 -> 10
      distance_to_center <= 5 -> 5
      distance_to_center <= 10 -> 1
      true -> 0
    end
  end
end
