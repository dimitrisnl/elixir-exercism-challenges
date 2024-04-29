defmodule BasketballWebsite do

  def extract_from_path(data, path) do
    extract_from_arr(data, String.split(path, "."))
  end

  defp extract_from_arr(data, []), do: data
  defp extract_from_arr(data, [head | tail]) do
    extract_from_arr(data[head], tail)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
