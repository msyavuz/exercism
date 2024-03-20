defmodule Username do
  def sanitize(username) do
    username
    |> Enum.reject(fn char ->
      (char < ?a or char > ?z) and
        char not in [?ä, ?ö, ?ü, ?ß, ?_]
    end)
    |> Enum.map(fn
      char ->
        case char do
          ?ä -> ~c"ae"
          ?ö -> ~c"oe"
          ?ü -> ~c"ue"
          ?ß -> ~c"ss"
          _ -> char
        end
    end)
    |> List.flatten()
  end
end
