defmodule ImageVac.Hashes do
  @salt "7fe741dcaaa9e012f09ca8058993358560592815edfcdedfa27b98a4cc6bbeb444df82671a1d84f15cec86d1466190d116c965c4c4457c5e5689e7b943fa7b98"
  @min_length 8

  def encode(thing) do
    Hashids.encode(hasher(), thing)
  end

  def decode(hash) do
    Hashids.decode(hasher(), hash)
  end

  defp hasher do
    Hashids.new([
      salt: @salt,
      min_len: @min_length,
    ])
  end
end
