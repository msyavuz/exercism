defmodule BinarySearch do
  require Integer

  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _) do
    :not_found
  end

  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  def search(numbers, key, 0, 1) when elem(numbers, 0) == key do
    {:ok, 0}
  end

  def search(numbers, key, min, max) when div(max - min, 2) == 0 and elem(numbers, max) == key do
    {:ok, max}
  end

  def search(numbers, key, min, max) do
    middle = ((max - min) |> div(2)) + min
    val = elem(numbers, middle)

    cond do
      val == key -> {:ok, middle}
      middle == max or middle == min -> :not_found
      val > key -> search(numbers, key, min, middle)
      val < key -> search(numbers, key, middle, max)
    end
  end
end
