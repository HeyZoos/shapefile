defmodule Shapefile.Shx do
  @moduledoc """
  """

  @doc """
  The number of 2-byte pairs from the start of the main file to the first byte
  of the record header. The offset for the first record in the main file is
  always 50, given that the header is 100 bytes (50 2-byte pairs).

  ## Examples

    iex> file = File.read!("test/fixtures/aircraft.shx") 
    iex> << _ :: unit(8)-size(100)-binary, body :: binary >> = file
    iex> Shapefile.Shx.offset(body)
    50

  """
  def offset(bytes) do
    << val :: unit(8)-size(4)-big, _ :: binary >> = bytes
    val
  end

  @doc """
  The content length is the length of the record stored at a given offset in 
  the main .shp file. The number returned is the number of 16-bit words, or
  2-byte pairs for length that record.
  """
  def content_length(bytes) do
    << _ :: unit(8)-size(4), len :: unit(8)-size(4)-big >> = bytes
    len
  end

  @doc """
  Parse the offset and content length from a set of 8 bytes.
  """
  def parse_record(bytes) do
    %{
      offset: offset(bytes),
      content_length: content_length(bytes)
    }
  end

  @doc """
  Parse records from a byte stream containing multiple records.

  ## Examples

    iex> shx = File.read!("test/fixtures/aircraft.shx")
    iex> << _ :: unit(8)-size(100), body :: binary >> = shx
    iex> Shapefile.Shx.parse_records(body)
    [%{content_length: 12552, offset: 50}]

  """
  def parse_records(<<>>), do: []
  def parse_records(bytes) do
    << record :: unit(8)-size(8)-binary, tail :: binary >> = bytes
    [ parse_record(record) | parse_records(tail) ]
  end

  @doc """
  Parse the header and index records from a .shx file. This is necessary 
  to parse a .shp file because of the offset and content length information
  provided by index records.

  ## Examples

    iex> shx = File.read!("test/fixtures/aircraft.shx") 
    iex> Shapefile.Shx.parse(shx)
    %{header: %{bbox: %{mmax: 0, mmin: 0, xmax: 13861690657312651908,
          xmin: 13861713156339110383, ymax: 4631621889855161241,
          ymin: 4631601456002246487, zmax: 0, zmin: 0}, file_code: 9994,
        file_length: 54, shape_type: 5, version: 1000},
      records: [%{content_length: 12552, offset: 50}]}

  """
  def parse(bytes) do
    << head :: unit(8)-size(100)-binary, tail :: binary >> = bytes

    %{
      header: Shapefile.Shp.header(head),
      records: parse_records(tail)
    }
  end
end