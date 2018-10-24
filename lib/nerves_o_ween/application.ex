defmodule NervesOWeen.Application do
  @target Mix.Project.config()[:target]

  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: NervesOWeen.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  def children(target) do
    [
      {NervesOWeen.Lights, [pin: 18, leds: 150]},
      {NervesOWeen.Worker, []},
    ]
  end
end
