defmodule Anagram do
  def get_diff_lists(list1, list2) do
    case Kernel.length(list1) > Kernel.length(list2) do
      true -> list1 -- list2
      _ -> list2 -- list1
    end
  end

  def get_uppercase_graphemes(string) do
    string
    |> String.upcase()
    |> String.graphemes()
  end

  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_graphemes = Anagram.get_uppercase_graphemes(base)

    candidates
    |> Enum.map(fn candidate ->
      candidate_graphemes = Anagram.get_uppercase_graphemes(candidate)

      if candidate_graphemes === base_graphemes do
        nil
      else
        case Anagram.get_diff_lists(candidate_graphemes, base_graphemes) do
          [] -> candidate
          _ -> nil
        end
      end
    end)
    |> Enum.reject(&is_nil/1)
  end
end
