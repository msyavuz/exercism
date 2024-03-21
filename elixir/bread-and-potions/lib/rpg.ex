defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_, character) do
      new_character =
        character
        |> Map.update!(:health, fn health -> health + 5 end)

      {nil, new_character}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(item, character) do
      new_character =
        character
        |> Map.update!(:mana, fn mana -> mana + item.strength end)

      {%RPG.EmptyBottle{}, new_character}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, character) do
      new_character =
        character
        |> Map.update!(:health, fn _ -> 0 end)

      {%RPG.EmptyBottle{}, new_character}
    end
  end
end
