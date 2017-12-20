defmodule Shapefile do
  @moduledoc """
  Documentation for Shapefile.
  """

  def parse(bytes) do
    Shapefile.Shp.parse(bytes)
  end
end