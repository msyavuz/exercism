defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, opts \\ []) do
    for top <- tops,
        bottom <- bottoms,
        Map.get(bottom, :base_color) != Map.get(top, :base_color),
        Map.get(bottom, :price) + Map.get(top, :price) <=
          Keyword.get(opts, :maximum_price, 100.00) do
      {top, bottom}
    end
  end
end
