defmodule TopSecret do
  def to_ast(string) do
    string
    |> Code.string_to_quoted!()
  end

  def decode_secret_message_part({operation, _, [definition | _]} = ast, acc)
      when operation in [:def, :defp] do
    {ast, List.flatten([get_secret(definition), acc])}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def get_secret(definition) do
    definition |> parse_def() |> parse_body()
  end

  def parse_def({:when, _, [fun_body | _]}), do: fun_body
  def parse_def({fun_body, _}), do: fun_body

  def parse_body({name, _, args}) do
    a = name |> to_string() |> String.slice(0, length(args))
    IO.puts(a)
  end

  def decode_secret_message(string) do
  end
end
