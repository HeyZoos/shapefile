defmodule Shapefile.ShxTest do
  use ExUnit.Case
  doctest Shapefile.Shx

  test :parse do
    shp = File.read!("test/fixtures/watersheds.shx")
    Shapefile.Shx.parse(shp)
  end
end