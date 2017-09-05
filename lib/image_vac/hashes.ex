defmodule ImageVac.Hashes do
  def encode(thing) do
    Hashids.encode(hasher(), thing)
  end

  def decode(hash) do
    Hashids.decode(hasher(), hash)
  end

  defp hasher do
    Hashids.new([
      salt: "123",
      min_len: 6,
    ])
  end
end
