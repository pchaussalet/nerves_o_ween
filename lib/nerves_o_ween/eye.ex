defmodule NervesOWeen.Eye do
  alias NervesOWeen.Lights

  def start() do
    fade_in(random(150), random(255), 0)
  end

  defp fade_in(left, red, red) do
    Lights.refresh(left, {red, 0, 0})
    Process.sleep(5)
    blink(left, red, random(2, 10))
  end

  defp fade_in(left, red, current) do
    Lights.refresh(left, {current, 0, 0})
    Process.sleep(5)
    fade_in(left, red, current + 1)
  end

  defp blink(left, red, 0) do
    fade_out(left, red)
  end

  defp blink(left, red, remaining_blinks) do
    Lights.refresh(left, {red, 0, 0})
    Process.sleep(random(2000))
    Lights.refresh(left, {0, 0, 0})
    Process.sleep(random(500))
    Lights.refresh(left, {red, 0, 0})
    Process.sleep(random(4000))
    Lights.refresh(left, {0, 0, 0})
    Process.sleep(random(250))
    blink(left, red, remaining_blinks - 1)
  end

  defp fade_out(left, 0) do
    Lights.refresh(left, {0, 0, 0})
  end

  defp fade_out(left, red) do
    Lights.refresh(left, {red, 0, 0})
    Process.sleep(10)
    fade_out(left, red - 1)
  end

  defp random(min \\ 0, max) do
    trunc(:rand.uniform() * max) + min
  end
end
