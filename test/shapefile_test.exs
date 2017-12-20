defmodule ShapefileTest do
  use ExUnit.Case
  doctest Shapefile

  test :parse do
    shp = File.read!("test/fixtures/watersheds.shp")
    Shapefile.parse(shp)
  end
end
