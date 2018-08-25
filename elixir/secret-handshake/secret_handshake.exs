defmodule SecretHandshake do
  def get_binary(code) do
    code
    |> Integer.to_string(2)
    |> String.to_integer()
  end

  def get_secret(code) do
    case code do
      1 ->
        "wink"

      10 ->
        "double blink"

      100 ->
        "close your eyes"

      1000 ->
        "jump"

      _ ->
        nil
    end
  end

  def remove_zero_at_beginnig(list) do
    if list |> List.starts_with?([0]) do
      list
      |> Enum.drop(1)
      |> remove_zero_at_beginnig()
    else
      list
    end
  end

  def generate_handeshake(list) do
    list
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      multiplicator = :math.pow(10, index) |> round()

      get_secret(item * multiplicator)
    end)
    |> Enum.reject(&is_nil/1)
  end

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    binary_code = get_binary(code)

    if div(binary_code, 10000) === 1 do
      binary_code
      |> Integer.digits()
      |> Enum.drop(1)
      |> remove_zero_at_beginnig()
      |> generate_handeshake()
      |> Enum.reverse()
    else
      binary_code
      |> Integer.digits()
      |> generate_handeshake()
    end
  end
end
