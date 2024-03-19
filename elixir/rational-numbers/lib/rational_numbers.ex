defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, a2}, {b1, b2}) do
    res = {a1 * b2 + a2 * b1, a2 * b2}
    reduce(res)
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, a2}, {b1, b2}) do
    res = {a1 * b2 - b1 * a2, a2 * b2}
    reduce(res)
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}) do
    res = {a1 * b1, a2 * b2}
    reduce(res)
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, a2}, {b1, b2}) when a2 !== 0 do
    res = {a1 * b2, a2 * b1}
    reduce(res)
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a1, a2}) do
    res = {Kernel.abs(a1), Kernel.abs(a2)}
    reduce(res)
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, a2}, n) when n >= 0 do
    res = {Integer.pow(a1, n), Integer.pow(a2, n)}
    reduce(res)
  end

  def pow_rational({a1, a2}, n) when n < 0 do
    res = {Integer.pow(a2, -n), Integer.pow(a1, -n)}
    reduce(res)
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {n1, n2}) do
    :math.pow(:math.pow(x, n1), 1 / n2)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a1, a2}) when a2 < 0 do
    reduce({-a1, -a2})
  end

  def reduce({a1, a2}) do
    denom = Integer.gcd(a1, a2)
    {div(a1, denom), div(a2, denom)}
  end
end
