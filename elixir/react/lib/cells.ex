defmodule Cells do
  use GenServer

  @impl true
  def init(init_cells) do
    {:ok, init_cells}
  end

  @impl true
  def handle_call({:get_cell_value, cell_name}, _from, state) do
    case List.keyfind(state, cell_name, 1) do
      {:input, _, value} ->
        {:reply, value, state}

      {:output, _, inputs, callback} ->
        {:reply, get_output_value(state, inputs, callback), state}
    end
  end

  defp get_output_value(state, inputs, callback) do
    values =
      inputs
      |> Enum.map(fn input ->
        {:input, _, value} = List.keyfind(state, input, 1)
        value
      end)

    # dbg(values)
    apply(callback, values)
  end

  @impl true
  def handle_cast({:set_input, cell_name, value}, state) do
    new_state =
      state
      |> Enum.map(fn
        {:input, ^cell_name, _} ->
          {:input, cell_name, value}

        cell ->
          cell
      end)

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:add_callback, cell_name, callback_name, callback}, state) do
    new_state =
      state
      |> Enum.map(fn {:output, ^cell_name, inputs, _} ->
        {:output, cell_name, [callback_name | inputs], callback}
      end)

    {:noreply, new_state}
  end
end
