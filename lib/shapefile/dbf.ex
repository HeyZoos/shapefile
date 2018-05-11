defmodule Shapefile.Dbf do
  @moduledoc """
  """

  @doc """
  ## Examples

      iex> Shapefile.Dbf.parse("", "test/fixtures/watersheds.dbf")
      nil

  """
  def parse(callback, filename, encoding \\ "utf-8") do
    {:ok, bytes} = File.read(filename)

    << type::binary-size(1), bytes::binary >> = bytes
    << date::binary-size(3), bytes::binary >> = bytes
    << number_of_records::binary-size(4), bytes::binary >> = bytes
    << start::binary-size(2), bytes::binary >> = bytes
    << record_length::binary-size(2), bytes::binary >> = bytes

    IO.inspect parse_date(date)
    parse_records(bytes, [])
  end

  def parse_records(<<>>, acc), do: Enum.reverse(acc)
  def parse_records(<< record::binary-size(32), tail::binary>>, acc) do
    parse_records(tail, [parse_record(record) | acc])
  end

  def parse_date(<<year::binary-size(1), month::binary-size(1), day::binary-size(1)>>) do
    << year >> = year
    << month >> = month
    << day >> = day

    %NaiveDateTime{
      year: 1900 + year,
      month: month - 1,
      day: day,
      hour: 0,
      minute: 0,
      second: 0
    }
  end

  def parse_record(<<
    name::binary-size(11), 
    type::binary-size(1),
    displacement::binary-size(4),
    length::binary-size(1),
    decimalPlaces::binary-size(1),
    _::binary>>) do
      %{
        name: name,
        type: type,
        displacement: displacement,
        length: length,
        decimalPlaces: decimalPlaces
      }
    end
end
