defmodule TopSecret do
  def to_ast(string) do
    string
    |> Code.string_to_quoted!()
  end

  def decode_secret_message_part({operation, _, definition} = ast, acc)
      when operation in [:def, :defp] do
    secret = definition |> parse_def() |> parse_body()
    {ast, [secret | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def parse_def([{:when, _, [fun_body | _]} | _]), do: fun_body
  def parse_def([fun_body | _]), do: fun_body

  def parse_body({_name, _, nil}), do: ""

  def parse_body({name, _, args}) do
    name |> to_string() |> String.slice(0, length(args))
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> Enum.join()
  end
end
