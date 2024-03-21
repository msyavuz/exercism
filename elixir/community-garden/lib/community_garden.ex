# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start_link(fn -> %{id: 0, plots: []} end)
  end

  def list_registrations(pid) do
    pid
    |> Agent.get(& &1.plots)
  end

  def register(pid, register_to) do
    pid
    |> Agent.get_and_update(fn %{id: id, plots: plots} ->
      plot = %Plot{plot_id: id + 1, registered_to: register_to}

      {plot, %{id: id + 1, plots: [plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    pid
    |> Agent.cast(fn %{id: id, plots: plots} ->
      %{id: id, plots: Enum.filter(plots, &(&1.plot_id != plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    plot =
      pid
      |> Agent.get(&Enum.find(&1.plots, fn plot -> plot.plot_id == plot_id end))

    cond do
      plot -> plot
      true -> {:not_found, "plot is unregistered"}
    end
  end
end
