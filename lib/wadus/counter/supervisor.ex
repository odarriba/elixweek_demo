defmodule Wadus.Counter.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    children = [
      worker(Wadus.Counter, [], restart: :temporary)
    ]

    supervise children, strategy: :one_for_one
  end
end
