defmodule CyberSourceSDK.Helper do
  @moduledoc """
  Small utility functions
  """

  @doc """
  Convert a Map that have the keys as strings to atoms

  ## Examples

      iex> CyberSourceSDK.Helper.convert_map_to_key_atom(%{"a" => 3, "b" => 5})
      %{a: 3, b: 5}

  """
  def convert_map_to_key_atom(string_key_map) when is_map(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), convert_map_to_key_atom(val)}
  end

  def convert_map_to_key_atom(list_maps) when is_list(list_maps) do
    Enum.map(list_maps, fn (map) -> convert_map_to_key_atom(map) end)
  end

  def convert_map_to_key_atom(string_key_map) when is_number(string_key_map) or is_nil(string_key_map) do
    string_key_map
  end

  def convert_map_to_key_atom(value) do
    if String.valid?(value) do
      value
    else
      Kernel.inspect(value) # Convert to string
    end
  end

  @doc """
  Decode Base64 string to JSON structure

  ## Examples

      iex> CyberSourceSDK.Helper.json_from_base64("eyJhIjogMiwgImIiOiAzfQ==")
      {:ok, %{a: 2, b: 3}}

  """
  def json_from_base64(base64_string) do
    case Base.decode64(base64_string) do
      {:ok, json} ->
        case Poison.Parser.parse(json) do
          {:ok, json} -> {:ok, convert_map_to_key_atom(json)}
          {:error, reason} -> {:error, reason}
        end
      _ -> {:error, :bad_base64_encoding}
    end
  end

  @doc """
  Check what type of payment is: Android Pay or Apple Pay

  ## Results

  - `{:ok, :android_pay}`
  - `{:ok, :apple_pay}`
  - `{:error, :not_found}`
  """
  def check_payment_type(encrypted_payload) do
    case json_from_base64(encrypted_payload) do
      {:ok, data} ->
        header = Map.get(data, :header)
        signature = Map.get(data, :signature)
        publicKeyHash = Map.get(data, :publicKeyHash)

        cond do
          !is_nil(header) && !is_nil(signature) -> {:ok, :apple_pay}
          !is_nil(publicKeyHash) -> {:ok, :android_pay}
          true -> {:ok, :not_found_payment_type}
        end

      {:error, _reason} -> {:error, :invalid_base64_or_json}
    end
  end
end
