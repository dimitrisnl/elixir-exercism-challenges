defmodule Secrets do
  def secret_add(secret) do
    fn adder ->
      adder + secret
    end
  end

  def secret_subtract(secret) do
    fn subtracter ->
      subtracter - secret
    end
  end

  def secret_multiply(secret) do
    fn multiplier ->
      multiplier * secret
    end
  end

  def secret_divide(secret) do
    fn divider ->
      div(divider, secret)
    end
  end

  def secret_and(secret) do
    fn ander ->
      Bitwise.band(secret, ander)
    end
  end

  def secret_xor(secret) do
    fn xorer ->
      Bitwise.bxor(secret, xorer)
    end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn prop ->
      secret_function2.(secret_function1.(prop))
    end
  end
end
