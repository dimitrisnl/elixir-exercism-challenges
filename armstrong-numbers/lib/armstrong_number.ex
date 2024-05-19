defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    count = Integer.digits(number) |> Enum.count()
    sum = Integer.digits(number) |> Enum.reduce(0, fn x, acc -> acc + x ** count end)
    sum == number
  end
end
