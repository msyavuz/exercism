defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([nucleotide | tail], acc) do
    do_encode(tail, <<acc::bitstring, encode_nucleotide(nucleotide)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<code::4, tail::bitstring>>, acc) do
    do_decode(tail, acc ++ [decode_nucleotide(code)])
  end
end
