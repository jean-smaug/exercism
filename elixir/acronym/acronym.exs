defmodule Acronym do
  def get_uppercases_in_word(word) do
    word
    |> String.graphemes()
    |> Enum.filter(fn w ->
      String.match?(w, ~r/[A-Z]/)
    end)
    |> Enum.join()
  end

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(" ")
    |> Enum.map(fn s ->
      cond do
        String.downcase(s) === s ->
          String.first(s)
          |> String.upcase()
        true ->
          Acronym.get_uppercases_in_word(s)
      end
    end)
    |> Enum.join()
  end
end
