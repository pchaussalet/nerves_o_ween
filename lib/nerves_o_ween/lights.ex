defmodule NervesOWeen.Lights do
  use GenServer
  alias Nerves.Neopixel

  @channel 0

  # API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def refresh(left, rgb) do
    GenServer.cast(__MODULE__, {:refresh, left, rgb})
  end

  # Internals
  def init([pin: pin, leds: leds]) do
    config = [pin: pin, count: leds]
    {:ok, _pid} = Neopixel.start_link(config)

    {:ok, Enum.map(0..leds, fn _ -> {0,0,0} end)}
  end

  def handle_cast({:refresh, left, rgb}, state) do
    right = left + 2
    new_state = state
                |> Enum.with_index()
                |> Enum.map(
                     fn
                       {_, ^left} -> rgb
                       {_, ^right} -> rgb
                       {original, _} -> original
                     end
                   )
    Neopixel.render(@channel, {127, new_state})

    {
      :noreply,
      new_state
    }
  end
end