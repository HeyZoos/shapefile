defmodule Shapefile.Shp.Record do
  @moduledoc """
  """

    def record_number(bytes) do
        << num :: unit(8)-size(4)-big >> = bytes
        num
    end

    def content_length(bytes) do
        << _ :: unit(8)-size(4), len :: unit(8)-size(4)-big >> = bytes
        len
    end

    def header(bytes) do
        %{
            number: record_number(bytes),
            length: content_length(bytes)
        }
    end
end