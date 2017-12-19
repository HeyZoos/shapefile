defmodule Shapefile do
  @moduledoc """
  Documentation for Shapefile.
  """

  @doc """
  Extracts the file code from the given binary. The file code is represented
  by the first 4 big endian bytes.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.file_code(file)
      9994

  """
  def file_code(header) do
    << code :: unit(8)-size(4)-big, _ :: binary >> = header
    code
  end

  @doc """
  Extracts the file length from the given binary. The file length is represented
  by the 4 big endian bytes at the 24th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.file_length(file)
      12606

  """
  def file_length(header) do
    << _ :: unit(8)-size(24), length :: unit(8)-size(4)-big, _ :: binary >> = header
    length
  end

  @doc """
  Extracts the version from the given binary. The version is represented
  by 4 little endian bytes at the 28th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.version(file)
      1000

  """
  def version(header) do
    << _ :: unit(8)-size(28), ver :: unit(8)-size(4)-little, _ :: binary >> = header
    ver
  end

  @doc """
  Extracts the shape type from the given binary. The shape type is represented
  by 4 little endian bytes at the 32nd byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.shape_type(file)
      1000

  """
  def shape_type(header) do
    << _ :: unit(8)-size(32), type :: unit(8)-size(4)-little, _ :: binary >> = header
    type
  end

  @doc """
  Extracts the xmin from the given binary. The xmin is represented
  by 8 little endian bytes at the 36th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.xmin(file)
      13861713156339110383

  """
  def xmin(header) do
    << _ :: unit(8)-size(36), min :: unit(8)-size(8)-little, _ :: binary >> = header
    min
  end

  @doc """
  Extracts the ymin from the given binary. The ymin is represented
  by 8 little endian bytes at the 44th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.ymin(file)
      4631601456002246487

  """
  def ymin(header) do
    << _ :: unit(8)-size(44), min :: unit(8)-size(8)-little, _ :: binary >> = header
    min
  end

  @doc """
  Extracts the xmax from the given binary. The xmax is represented
  by 8 little endian bytes at the 52nd byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.xmax(file)
      13861690657312651908

  """
  def xmax(header) do
    << _ :: unit(8)-size(52), max :: unit(8)-size(8)-little, _ :: binary >> = header
    max
  end

  @doc """
  Extracts the ymax from the given binary. The ymax is represented
  by 8 little endian bytes at the 60th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.ymax(file)
      4631621889855161241

  """
  def ymax(header) do
    << _ :: unit(8)-size(60), max :: unit(8)-size(8)-little, _ :: binary >> = header
    max
  end

  @doc """
  Extracts the zmin from the given binary. The zmin is represented
  by 8 little endian bytes at the 68th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.zmin(file)
      0

  """
  def zmin(header) do
    << _ :: unit(8)-size(68), min :: unit(8)-size(8)-little, _ :: binary >> = header
    min
  end

  @doc """
  Extracts the zmax from the given binary. The zmax is represented
  by 8 little endian bytes at the 76th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.zmax(file)
      0

  """
  def zmax(header) do
    << _ :: unit(8)-size(76), max :: unit(8)-size(8)-little, _ :: binary >> = header
    max
  end

  @doc """
  Extracts the mmin from the given binary. The mmin is represented
  by 8 little endian bytes at the 84th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.mmin(file)
      0

  """
  def mmin(header) do
    << _ :: unit(8)-size(84), min :: unit(8)-size(8)-little, _ :: binary >> = header
    min
  end

  @doc """
  Extracts the mmax from the given binary. The mmax is represented
  by 8 little endian bytes at the 92nd byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.mmax(file)
      0

  """
  def mmax(header) do
    << _ :: unit(8)-size(92), max :: unit(8)-size(8)-little, _ :: binary >> = header
    max
  end

  @doc """
  Extracts the bounding box from the given binary. The bounding box is represented
  by the last 64 little endian bytes starting at the 36th byte position.

  ## Examples

      iex> file = File.read!("shapefile.shp") 
      iex> Shapefile.bbox(file)
      %{mmax: 0, mmin: 0, xmax: 13861690657312651908, xmin: 13861713156339110383,
        ymax: 4631621889855161241, ymin: 4631601456002246487, zmax: 0, zmin: 0}

  """
  def bbox(header) do
    %{
      xmin: xmin(header),
      ymin: ymin(header),
      xmax: xmax(header),
      ymax: ymax(header),
      zmin: zmin(header),
      zmax: zmax(header),
      mmin: mmin(header),
      mmax: mmax(header) 
    }
  end
end