defmodule Newsletter do
  def read_emails(path) do
    contents = File.read!(path)
    String.split(contents, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_pid = open_log(log_path)

    Enum.each(emails, fn email ->
      response = send_fun.(email)
      if response == :ok do log_sent_email(log_pid, email) end
    end)

    close_log(log_pid)
  end
end
