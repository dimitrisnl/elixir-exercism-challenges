defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?(list), do: 0 in list

  def total([]), do: 0
  def total([head | tail]), do: total(tail) + head

  def busy_days([]), do: 0
  def busy_days([head | tail]) when head > 4, do: busy_days(tail) + 1
  def busy_days([_ | tail]), do: busy_days(tail)
end
