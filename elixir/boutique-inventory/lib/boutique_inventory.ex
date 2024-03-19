defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(!&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      Map.put(item, :name, String.replace(Map.fetch!(item, :name), old_word, new_word))
    end)
    |> Enum.into([])
  end

  def increase_quantity(item, count) do
    %{
      item
      | quantity_by_size:
          Map.new(item.quantity_by_size, fn {size, val} ->
            {size, val + count}
          end)
    }
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, &(elem(&1, 1) + &2))
  end
end
