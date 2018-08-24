defmodule ProteinTranslation do
  def get_codons(rna) do
    rna
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.map(fn item -> Enum.join(item) end)
  end

  def has_stop_codon(proteins) do
    proteins
    |> Enum.find_index(fn protein -> protein === "STOP" end)
  end

  def has_invalid_codon(proteins) do
    proteins
    |> Enum.find_value(fn protein -> protein === :error end)
  end

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins =
      rna
      |> ProteinTranslation.get_codons()
      |> Enum.map(fn codon ->
        {status, name} = ProteinTranslation.of_codon(codon)

        if status === :error do
          :error
        else
          name
        end
      end)

    stop_codon_index = ProteinTranslation.has_stop_codon(proteins)

    cond do
      has_invalid_codon(proteins) -> {:error, "invalid RNA"}
      stop_codon_index === nil -> {:ok, proteins}
      true -> {:ok, Enum.take(proteins, stop_codon_index)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case codon do
      "AUG" ->
        {:ok, "Methionine"}

      "UUU" ->
        {:ok, "Phenylalanine"}

      "UUC" ->
        {:ok, "Phenylalanine"}

      "UUA" ->
        {:ok, "Leucine"}

      "UUG" ->
        {:ok, "Leucine"}

      "UCU" ->
        {:ok, "Serine"}

      "UCC" ->
        {:ok, "Serine"}

      "UCA" ->
        {:ok, "Serine"}

      "UCG" ->
        {:ok, "Serine"}

      "UGU" ->
        {:ok, "Cysteine"}

      "UGC" ->
        {:ok, "Cysteine"}

      "UAU" ->
        {:ok, "Tyrosine"}

      "UAC" ->
        {:ok, "Tyrosine"}

      "UGG" ->
        {:ok, "Tryptophan"}

      "UAA" ->
        {:ok, "STOP"}

      "UAG" ->
        {:ok, "STOP"}

      "UGA" ->
        {:ok, "STOP"}

      _ -> {:error, "invalid codon"}
    end
  end
end
