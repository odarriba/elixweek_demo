defmodule Wadus.Calculator do
  def init do
    # Start a new process and return it's PID
    spawn fn -> process_loop() end
  end

  # Internal processing loop
  defp process_loop() do
    receive do
      {:sum, caller, a, b} when is_integer(a) and is_integer(b) ->
        send caller, {:ok, a+b}
      {:multiply, caller, a, b} when is_integer(a) and is_integer(b) ->
        send caller, {:ok, a*b}
      {_, caller, _, _} ->
          send caller, {:error, "Unknown action or params"}
    end
    process_loop
  end

  # Public API
  def calc(process, op, a, b) do
    send process, {op, self(), a, b}

    receive do
      {:ok, result} -> "The result is #{result}"
      {:error, desc} -> "Error: #{desc}"
    after
      1_000 -> "Nothing after 1s"
    end
  end
end
