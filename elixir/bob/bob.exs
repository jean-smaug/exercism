defmodule Bob do
  def is_capitalized?(string) do
    uppercaseString =
      string
      |> String.upcase()

    uppercaseString === string
  end

  def is_exclamation?(string) do
    String.ends_with?(string, "!")
  end

  def is_interrogation?(string) do
    String.ends_with?(string, "?")
  end

  def contains_letters?(string) do
    String.match?(string, ~r/[a-zA-Z\p{L}]/)
  end

  def is_silence?(string) do
    String.trim(string) === ""
  end

  def hey(input) do
    cond do
      Bob.is_silence?(input) ->
        "Fine. Be that way!"

      !Bob.contains_letters?(input) && Bob.is_interrogation?(input) ->
        "Sure."

      !Bob.contains_letters?(input) ->
        "Whatever."

      Bob.is_exclamation?(input) && Bob.is_capitalized?(input) ->
        "Whoa, chill out!"

      Bob.is_interrogation?(input) && Bob.is_capitalized?(input) ->
        "Calm down, I know what I'm doing!"

      Bob.is_capitalized?(input) ->
        "Whoa, chill out!"

      Bob.is_interrogation?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
