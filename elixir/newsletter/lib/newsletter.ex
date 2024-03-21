defmodule Newsletter do
  def read_emails(path) do
    {_, file} = File.read(path)

    case file do
      "" -> []
      _ -> file |> String.split()
    end
  end

  def open_log(path) do
    {:ok, file} = File.open(path, [:write])
    file
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
      cond do
        send_fun.(email) == :ok ->
          log_sent_email(log, email)

        true ->
          nil
      end
    end)

    close_log(log)
  end
end
