defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.reject(&(String.downcase(&1) == String.downcase(base)))
    |> Enum.filter(fn candidate ->
      cand_freq = candidate |> String.downcase() |> to_charlist() |> Enum.frequencies()
      base_freq = base |> String.downcase() |> to_charlist() |> Enum.frequencies()
      cand_freq == base_freq
    end)
  end
end
