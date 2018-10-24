defmodule NervesOWeen.Worker do
  use Task
  alias NervesOWeen.Eye

  def start_link(_opts) do
    Task.start_link(__MODULE__, :open_eye, [])
  end

  def open_eye() do
    spawn(Eye, :start, [])
    Process.sleep(trunc(:rand.uniform() * 30000))
    NervesOWeen.Worker.open_eye()
  end
end
