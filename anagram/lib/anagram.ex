defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    target = normalize(base)

    Enum.filter(candidates, fn candidate ->
      normalized_candidate = normalize(candidate)
      String.downcase(base) != String.downcase(candidate) && normalized_candidate == target
    end)
  end

  @spec normalize(String.t()) :: [String.t()]
  defp normalize(word) do
    word
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.sort()
    |> List.to_string()
  end
end
