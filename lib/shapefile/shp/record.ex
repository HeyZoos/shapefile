defmodule Shapefile.Shp.Record do
  @moduledoc """
  """

    def record_number(bytes) do
        << num :: unit(8)-size(4)-big, _ :: binary >> = bytes
        num
    end

    def content_length(bytes) do
        << _ :: unit(8)-size(4), len :: unit(8)-size(4)-big, _ :: binary >> = bytes
        len
    end

    def header(bytes) do
        %{
            number: record_number(bytes),
            length: content_length(bytes)
        }
    end

    def parse_record(bytes) do
        byte_size(bytes)
    end

    def parse(<<>>), do: []
    def parse(bytes) do
        IO.inspect head = header(bytes)
        len = head[:length]
        << record :: unit(16)-size(len)-binary, bytes :: binary >> = bytes
        [ parse_record(record) | parse(bytes) ]
    end
end