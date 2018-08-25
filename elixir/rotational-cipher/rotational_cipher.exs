defmodule RotationalCipher do
  def cipher(codepoint, shift, maxCodepoint) do
    newCodepoint = codepoint + rem(shift, 26)

    if newCodepoint > maxCodepoint do
      newCodepoint - 26
    else
      newCodepoint
    end
  end

  def is_letter(input) do
    cond do
      String.match?(input, ~r/[a-z]/) ->
        :lowercase

      String.match?(input, ~r/[A-Z]/) ->
        :uppercase

      true ->
        :notaletter
    end
  end

  def cipherLetters(text, shift) do
    text
    |> String.codepoints()
    |> Enum.map(fn letter ->
      case is_letter(letter) do
        :uppercase ->
          <<codepoint::utf8>> = letter
          newCodepoint = cipher(codepoint, shift, 90)
          <<newCodepoint::utf8>>

        :lowercase ->
          <<codepoint::utf8>> = letter
          newCodepoint = cipher(codepoint, shift, 122)
          <<newCodepoint::utf8>>

        :notaletter ->
          letter
      end
    end)
    |> Enum.join()
  end

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    cipherLetters(text, shift)
  end
end
