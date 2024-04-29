defmodule Lasagna do
  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(minutes) do
    expected_minutes_in_oven() - minutes
  end

  def preparation_time_in_minutes(num_of_layers) do
    num_of_layers * 2
  end

  def total_time_in_minutes(num_of_layers, num_of_minutes_oven) do
    num_of_minutes_oven + preparation_time_in_minutes(num_of_layers)
  end

  def alarm() do
    "Ding!"
  end
end
