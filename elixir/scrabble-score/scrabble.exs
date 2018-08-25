defmodule Scrabble do
  def get_letter_score(letter) do
    cond do
      Enum.member?(["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"], letter) -> 1
      Enum.member?(["D", "G"], letter) -> 2
      Enum.member?(["B", "C", "M", "P"], letter) -> 3
      Enum.member?(["F", "H", "V", "W", "Y"], letter) -> 4
      Enum.member?(["K"], letter) -> 5
      Enum.member?(["J", "X"], letter) -> 8
      Enum.member?(["Q", "Z"], letter) -> 10
      true -> 0
    end
  end

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.graphemes()
    |> Enum.reduce(0, fn w, acc ->
      letter_score =
        w
        |> String.upcase()
        |> Scrabble.get_letter_score()

      letter_score + acc
    end)
  end
end
