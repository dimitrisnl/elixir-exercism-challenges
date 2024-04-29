# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> %{plots: [], index: 0} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, index: index} ->
      index = index + 1
      next_plot = %Plot{plot_id: index, registered_to: register_to}
      state = %{plots: [next_plot | plots], index: index}
      {next_plot, state}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{plots: plots, index: index} ->
      next_plots = Enum.filter(plots, fn %{plot_id: p} -> p != plot_id end)
      state = %{plots: next_plots, index: index}
      state
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      plot = Enum.find(plots, fn %{plot_id: p} -> p == plot_id end)
      case plot do
        nil -> {:not_found, "plot is unregistered"}
        _ -> plot
      end
    end)
  end
end
