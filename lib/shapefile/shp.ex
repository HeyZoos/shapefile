defmodule Shapefile.Shp do
  @moduledoc """
  """
  
  @shape_types %{
    0 => :null_shape,
    1 => :point,
    3 => :polyline,
    5 => :polygon,
    8 => :multipoint,
    11 => :pointz,
    13 => :polylinez,
    15 => :polygonz,
    18 => :multipointz,
    21 => :pointm,
    23 => :polylinem,
    25 => :polygonm,
    28 => :multipointm,
    31 => :multipatch
  }

  @doc """
  Extracts the file code from the given binary. The file code is represented
  by the first 4 big endian bytes.

  ## Examples

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> << code :: size(4)-binary, _ :: binary >> = shp
      iex> Shapefile.Shp.file_code(code)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.file_length(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.version(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.shape_type(shp)
      5

  """
  def shape_type(header) do
    << _ :: unit(8)-size(32), type :: unit(8)-size(4)-little, _ :: binary >> = header
    type
  end

  @doc """
  Extracts the xmin from the given binary. The xmin is represented
  by 8 little endian bytes at the 36th byte position.

  ## Examples

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.xmin(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.ymin(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.xmax(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.ymax(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.zmin(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.zmax(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.mmin(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.mmax(shp)
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

      iex> shp = File.read!("test/fixtures/aircraft.shp") 
      iex> Shapefile.Shp.bbox(shp)
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

  @doc """
  Extracts the header values from the given binary. The header is represented
  by the first 100 bytes of a shapefile.

  ## Examples

      iex> file = File.read!("test/fixtures/aircraft.shp") 
      iex> << head :: unit(8)-size(100)-binary, _ :: binary >> = file
      iex> Shapefile.Shp.header(head)
      %{bbox: %{mmax: 0, mmin: 0, xmax: 13861690657312651908,
        xmin: 13861713156339110383, ymax: 4631621889855161241,
        ymin: 4631601456002246487, zmax: 0, zmin: 0}, file_code: 9994,
      file_length: 12606, shape_type: 5, version: 1000}

  """
  def header(bytes) do
    %{
      file_code: file_code(bytes),
      file_length: file_length(bytes),
      version: version(bytes),
      shape_type: shape_type(bytes),
      bbox: bbox(bytes)
    }
  end

  @doc """
  Extracts the record number value from a given binary. The header is represented
  by 4 big endian bytes.

  ## Examples

      iex> file = File.read!("test/fixtures/aircraft.shp") 
      iex> << _ :: unit(8)-size(100)-binary, content :: binary >> = file
      iex> << number :: size(4)-binary, _ :: binary >> = content
      iex> Shapefile.Shp.record_number(number)
      1

  """
  def record_number(<< num :: unit(8)-size(4)-big >>), do: num

  @doc """
  Extracts the record length value from a given binary. The length is represented
  by 4 big endian bytes. The number returned is the record's size in 16-bit words.

  ## Examples

    iex> file = File.read!("test/fixtures/aircraft.shp") 
    iex> << _ :: unit(8)-size(100)-binary, content :: binary >> = file
    iex> << _ :: size(4)-binary, len :: size(4)-binary, _ :: binary >> = content
    iex> Shapefile.Shp.record_length(len)
    12552

  """
  def record_length(<< len :: unit(8)-size(4)-big >>), do: len

  @doc """
  Extracts the record type value from a given binary. The type is represented
  by 4 little endian bytes. The number returned is one of the `@shape_types`.

  ## Examples

    iex> file = File.read!("test/fixtures/aircraft.shp") 
    iex> << _ :: unit(8)-size(100)-binary, content :: binary >> = file
    iex> << _ :: size(8)-binary, type :: size(4)-binary, _ :: binary >> = content
    iex> Shapefile.Shp.record_type(type)
    5

  """
  def record_type(<< type :: unit(8)-size(4)-little >>), do: type

  @doc """
  Extracts the record header from a given binary. The header is represented
  by 8 big endian bytes. The header contains information about the record's number
  and length.

  ## Examples

    iex> file = File.read!("test/fixtures/aircraft.shp") 
    iex> << _ :: unit(8)-size(100)-binary, body :: binary >> = file
    iex> << record_head :: size(8)-binary, _ :: binary >> = body
    iex> Shapefile.Shp.record_header(record_head)
    %{
      number: 1,
      length: 12552
    }

  """
  def record_header(<< header :: size(8)-binary >>) do
    << number :: size(4)-binary, len :: size(4)-binary >> = header

    %{
        number: record_number(number),
        length: record_length(len)
    }
  end

  @doc """
  Extracts the record type and shape from a given binary. 

  ## Examples

    iex> file = File.read!("test/fixtures/aircraft.shp") 
    iex> << _ :: unit(8)-size(100)-binary, body :: binary >> = file
    iex> << _ :: size(8)-binary, body :: binary >> = body
    iex> Shapefile.Shp.parse_record(1, body)
    %{
      number: 1,
      record: 12550.0,
      type: 5
    }

  """
  def parse_record(number, record) do
    << type :: size(4)-binary, contents :: binary >> = record

    %{
      number: number,
      type: record_type(type),
      record: bit_size(contents) / 16
    }
  end

  @doc """
  Given a the file content of a .shp file, extract the record into a
  list of maps.

  ## Examples

    # iex> shp = File.read!("test/fixtures/watersheds.shp")
    # iex> << _ :: size(100)-binary, body >> = shp
    # iex> Shapefile.Shp.parse(body)
    [%{number: 1, record: 7222.0, type: 5},
      %{number: 2, record: 3230.0, type: 5}, 
      %{number: 3, record: 6392.0, type: 5},
      %{number: 4, record: 3006.0, type: 5},
      %{number: 5, record: 10878.0, type: 5},
      %{number: 6, record: 2080.0, type: 5},
      %{number: 7, record: 19144.0, type: 5}]

  """
  def parse_records(<<>>), do: []
  def parse_records(bytes) do
      << head :: size(8)-binary, bytes :: binary >> = bytes
      %{number: number, length: len} = record_header(head)
      << record :: unit(16)-size(len)-binary, tail :: binary >> = bytes
      [ parse_record(number, record) | parse_records(tail) ]
  end

  @doc """
  Parse a .shp binary.

  ## Examples

    # iex> shp = File.read!("test/fixtures/watersheds.shp")
    # iex> Shapefile.Shp.parse(shp)
    %{header: %{bbox: %{mmax: 0, mmin: 0, xmax: 13861677400097999498,
          xmin: 13861718121316116984, ymax: 4631621822330553015,
          ymin: 4631585345496515183, zmax: 0, zmin: 0}, file_code: 9994,
        file_length: 52044, shape_type: 5, version: 1000},
      records: [%{number: 1, record: 7222.0, type: 5},
      %{number: 2, record: 3230.0, type: 5}, %{number: 3, record: 6392.0, type: 5},
      %{number: 4, record: 3006.0, type: 5},
      %{number: 5, record: 10878.0, type: 5},
      %{number: 6, record: 2080.0, type: 5},
      %{number: 7, record: 19144.0, type: 5}]}

  """
  def parse(bytes) do
    << head :: unit(8)-size(100)-binary, body :: binary >> = bytes

    %{
      header: header(head),
      records: parse_records(body)
    }
  end
end
