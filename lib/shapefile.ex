defmodule Shapefile do
  @moduledoc """
  Documentation for Shapefile.
  """

  def parse(bytes) do
    << head :: unit(8)-size(100)-binary, body :: binary >> = bytes

    %{
        header: Shapefile.Shp.header(head),
        records: Shapefile.Shp.Record.parse(body)
    }
  end
end