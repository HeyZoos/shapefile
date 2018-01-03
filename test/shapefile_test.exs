defmodule ShapefileTest do
  use ExUnit.Case
  doctest Shapefile

  @multipointz_fixture_path "test/fixtures/multipoint.shp"

  test :parse do
    multipoint = Shapefile.read!(@multipointz_fixture_path)
    Poison.encode!(multipoint)
  end
end
