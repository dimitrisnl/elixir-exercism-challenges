defmodule GuessingGame do
  def compare(secret_number, guess \\ :no_guess)
  def compare(_secret_number, :no_guess), do: "Make a guess"
  def compare(secret_number, guess) when guess == secret_number, do: "Correct"
  def compare(secret_number, guess) when guess > secret_number + 2, do: "Too high"
  def compare(secret_number, guess) when guess < secret_number - 2, do: "Too low"
  def compare(_secret_number, _guess), do: "So close"
end
