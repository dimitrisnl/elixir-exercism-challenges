defmodule FileSniffer do
  @file_extensions [
    {"exe", "application/octet-stream"},
    {"bmp", "image/bmp"},
    {"png", "image/png"},
    {"jpg", "image/jpg"},
    {"gif", "image/gif"}
  ]

  def type_from_extension(extension) do
    case Enum.find(@file_extensions, fn {ext, _} -> ext == extension end) do
      nil -> nil
      {_, type} -> type
    end
  end

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "image/png"
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "application/octet-stream"
      <<0x42, 0x4D, _::binary>> -> "image/bmp"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "image/jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "image/gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    expected_type = type_from_extension(extension)
    actual_type = type_from_binary(file_binary)

    cond do
      expected_type == nil -> {:error, "Warning, file format and file extension do not match."}
      actual_type == nil -> {:error, "Warning, file format and file extension do not match."}
      expected_type == actual_type -> {:ok, actual_type}
      true -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
