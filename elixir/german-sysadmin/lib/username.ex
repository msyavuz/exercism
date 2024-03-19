defmodule Username do
  def sanitize(username) do
    List.delete(username, ~c"")
  end
end
