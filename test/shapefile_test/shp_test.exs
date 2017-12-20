defmodule Shapefile.ShpTest do
  use ExUnit.Case
  doctest Shapefile.Shp

  test :parse do
    shp = File.read!("test/fixtures/watersheds.shp")
    Shapefile.Shp.parse(shp)
  end
end