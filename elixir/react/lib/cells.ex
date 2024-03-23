defmodule Cells do
  use GenServer

  @type react_cells :: [React.cell()]
  @type cell_state ::
          {:input, String.t(), any}
          | {:output, String.t(), [String.t()], fun(), any(), [{String.t(), fun()}]}

  @type cells :: [cell_state()]

  @impl true
  @spec init(react_cells()) :: {:ok, cells()}
  def(init(init_cells)) do
    {:ok, init_cells |> add_value_to_outputs() |> update_outputs()}
  end

  @impl true
  @spec handle_call({:get_cell_value, String.t()}, any(), cells()) :: {:reply, any(), cells()}
  def handle_call({:get_cell_value, cell_name}, _from, cells) do
    case List.keyfind(cells, cell_name, 1) do
      {:input, _, value} ->
        {:reply, value, cells}

      {:output, _, _, _, value, _callbacks} ->
        {:reply, value, cells}
    end
  end

  @impl true
  @spec handle_cast({:set_input, String.t(), any()}, cells()) :: {:noreply, cells()}
  def handle_cast({:set_input, cell_name, value}, state) do
    new_state =
      state
      |> Enum.map(fn
        {:input, ^cell_name, _} ->
          {:input, cell_name, value}

        cell ->
          cell
      end)

    {:noreply, update_outputs(new_state)}
  end

  @impl true
  @spec handle_cast({:add_callback, String.t(), String.t(), fun()}, cells()) ::
          {:noreply, cells()}
  def handle_cast({:add_callback, cell_name, callback_name, callback}, cells) do
    new_cells =
      cells
      |> Enum.map(fn
        {:output, ^cell_name, deps, valuefun, val, callbacks} ->
          {:output, cell_name, deps, valuefun, val, [{callback_name, callback} | callbacks]}

        input_cell ->
          input_cell
      end)

    {:noreply, update_outputs(new_cells)}
  end

  def handle_cast({:remove_callback, cell_name, callback_name}, cells) do
    new_cells =
      cells
      |> Enum.map(fn
        {:output, ^cell_name, deps, valuefun, val, callbacks} ->
          {:output, cell_name, deps, valuefun, val,
           Enum.reject(callbacks, fn {name, _callback} -> name == callback_name end)}

        input_cell ->
          input_cell
      end)

    {:noreply, new_cells}
  end

  @impl true
  @spec handle_info(:update_outputs, cells()) :: {:noreply, cells()}
  def handle_info(:update_outputs, cells) do
    {:noreply, update_outputs(cells)}
  end

  @spec get_value(cells(), [String.t()], fun()) :: any()
  defp get_value(cells, deps, valuefun) do
    values =
      deps
      |> Enum.map(fn dep ->
        case List.keyfind(cells, dep, 1) do
          {:input, _, value} ->
            value

          {:output, _, deps, valuefun, _value, _callbacks} ->
            get_value(cells, deps, valuefun)
        end
      end)

    # dbg(values)
    apply(valuefun, values)
  end

  @spec update_outputs(cells()) :: cells()
  defp update_outputs(cells) do
    Enum.map(cells, fn
      {:output, name, inputs, valuefun, value, callbacks} = output_cell ->
        new_value = get_value(cells, inputs, valuefun)

        cond do
          value != new_value ->
            fire_callbacks(new_value, callbacks)
            {:output, name, inputs, valuefun, new_value, callbacks}

          true ->
            output_cell
        end

      input_cell ->
        input_cell
    end)
  end

  defp fire_callbacks(new_val, callbacks) do
    callbacks
    |> Enum.each(fn {name, callback} -> callback.(name, new_val) end)
  end

  @spec add_value_to_outputs(react_cells()) :: cells()
  defp add_value_to_outputs(cells) do
    cells
    |> Enum.map(fn
      {:output, name, inputs, valuefun} ->
        {:output, name, inputs, valuefun, 0, []}

      input_cell ->
        input_cell
    end)
  end
end
