defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  def convert(_digits, input_base, _output_base) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(_digits, _input_base, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert(digits, input_base, output_base) do
    case Enum.any?(digits, fn digit -> digit < 0 or digit >= input_base end) do
      true -> {:error, "all digits must be >= 0 and < input base"}
      false -> do_convert(digits, input_base, output_base)
    end
  end

  def do_convert(digits, input_base, output_base) do
    number = digits |> to_decimal(input_base) |> to_base(output_base) |> Enum.reverse()

    {:ok, number}
  end

  @spec to_decimal(list, integer) :: integer
  defp to_decimal(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index(0)
    |> Enum.reduce(0, fn {num, idx}, acc -> acc + num * input_base ** idx end)
  end

  @spec to_base(integer, integer) :: list
  defp to_base(decimal, output_base) when output_base > decimal do
    [decimal]
  end

  defp to_base(decimal, output_base) do
    remainder = rem(decimal, output_base)
    quotient = div(decimal, output_base)

    [remainder | to_base(quotient, output_base)]
  end
end
