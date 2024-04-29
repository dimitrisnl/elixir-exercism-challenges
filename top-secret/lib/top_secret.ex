defmodule TopSecret do
  def to_ast(string) do
    case Code.string_to_quoted(string) do
      {:ok, ast} -> ast
      _ -> nil
    end
  end

  def decode_secret_message_part({operation, _, args} = ast, acc)
      when operation in [:def, :defp] do
    {name, arity} = get_function_name_and_arity(args)
    message = name |> Atom.to_string() |> String.slice(0, arity)
    {ast, [message | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp get_function_name_and_arity(def_args) do
    case def_args do
      [{:when, _, args}, _] -> get_function_name_and_arity(args)
      [{name, _, args}, _] when is_list(args) -> {name, length(args)}
      [{name, _, _}, _] -> {name, 0}
    end
  end

  def decode_secret_message(string) do
    string
    |> to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> then(fn {_, acc} -> acc end)
    |> Enum.reverse()
    |> Enum.join("")
  end
end
