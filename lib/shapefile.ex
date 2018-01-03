defmodule Shapefile do
  @moduledoc """
  Documentation for Shapefile.
  """

  def read!(path) do
    shpfile = File.read!(path)
    Shapefile.Shp.parse(shpfile)
  end

  def stream!(path) do
  end
end
