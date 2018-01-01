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

  @integer_byte_size 4
  @double_byte_size 8

  @point_byte_size 16 

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
    <<code::unit(8)-size(4)-big, _::binary>> = header
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
    <<_::unit(8)-size(24), length::unit(8)-size(4)-big, _::binary>> = header
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
    <<_::unit(8)-size(28), ver::unit(8)-size(4)-little, _::binary>> = header
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
    <<_::unit(8)-size(32), type::unit(8)-size(4)-little, _::binary>> = header
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
    <<_::unit(8)-size(36), min::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(44), min::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(52), max::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(60), max::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(68), min::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(76), max::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(84), min::unit(8)-size(8)-little, _::binary>> = header
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
    <<_::unit(8)-size(92), max::unit(8)-size(8)-little, _::binary>> = header
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
  Extracts the bounding box from the given binary for a record. 

  ## Examples

  """
  def record_bbox(<<bytes::size(32)-binary>>) do
    <<
      xmin::unit(8)-size(8)-little-float,
      ymin::unit(8)-size(8)-little-float,
      xmax::unit(8)-size(8)-little-float,
      ymax::unit(8)-size(8)-little-float
    >> = bytes

    %{
      xmin: xmin,
      ymin: ymin,
      xmax: xmax,
      ymax: ymax
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
  def record_number(<<num::unit(8)-size(4)-big>>), do: num

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
  def record_length(<<len::unit(8)-size(4)-big>>), do: len

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
  def record_type(<<type::unit(8)-size(4)-little>>), do: type

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
  def record_header(<<header::size(8)-binary>>) do
    <<number::size(4)-binary, len::size(4)-binary>> = header

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
    iex> nil
    nil

  """
  def parse_record(number, record) do
    <<type::unit(8)-size(4)-little, _::binary>> = record

    parsefn =
      case @shape_types[type] do
        :point -> &parse_point/1
        :polyline -> &parse_polyline/1
        :polygon -> &parse_polygon/1
        :multipoint -> &parse_multipoint/1
        :multipointz -> &parse_multipointz/1
        _ -> raise(ArgumentError, message: "Invalid type: #{type}")
      end

    %{
      number: number,
      record: parsefn.(record)
    }
  end

  @doc """
  A point consists of a pair of double-precision coordinates in the order X,Y.

  ## Examples

      iex> Shapefile.Shp.parse_point(<<
      ...>   0, 0, 0, 0, 0, 0, 0, 0,
      ...>   0, 0, 0, 0, 0, 0, 0, 0
      ...> >>)
      %{x: 0.0, y: 0.0}

  """
  def parse_point(<<bytes::size(16)-binary>>) do
    <<
      x::unit(8)-size(8)-little-float,
      y::unit(8)-size(8)-little-float
    >> = bytes

    %{
      x: x,
      y: y
    }
  end

  @doc """
  """
  def parse_polygon(bytes) do
    <<
      type::unit(8)-size(4)-little,
      box::size(32)-binary,
      num_parts::unit(8)-size(4)-little,
      num_points::unit(8)-size(4)-little,
      bytes::binary
    >> = bytes

    parts_bytes_len = @integer_byte_size * num_parts
    <<parts_bytes::size(parts_bytes_len)-binary, bytes::binary>> = bytes
    parts = parse_parts(parts_bytes, num_parts)

    %{
      shape_type: type,
      box: record_bbox(box),
      num_parts: num_parts,
      num_points: num_points,
      parts: parts,
      polygon: parse_point_parts(parts, bytes)
    }
  end

  @doc """
  A multipoint represents a set of points.

  ## Examples

  """
  def parse_multipoint(bytes) do
    <<
      type::unit(8)-size(4)-little,
      box::size(32)-binary,
      num_points::unit(8)-size(4)-little,
      points::binary
    >> = bytes

    %{
      type: type,
      box: record_bbox(box),
      num_points: num_points,
      points: parse_points(points)
    }
  end

  @doc """
  A measured point, "measured" shapes have an additional coordinate "M".
  Represented by 28 little endian bytes.

  ## Example

    iex> bytes = <<
    ...>   21, 0, 0, 0, 1, 0, 0, 0, 0, 0, 
    ...>   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
    ...>   1, 0, 0, 0, 0, 0, 0, 0
    ...> >>
    iex> Shapefile.Shp.parse_pointm(bytes)
    %{
      type: 21,
      x: 1,
      y: 1,
      m: 1
    }

  """
  def parse_pointm(<<bytes::size(28)-binary>>) do
    <<
      type::unit(8)-size(4)-little,
      x::unit(8)-size(8)-little,
      y::unit(8)-size(8)-little,
      m::unit(8)-size(8)-little
    >> = bytes

    %{type: type, x: x, y: y, m: m}
  end

  @doc """
  A PolyLine is an ordered set of vertices that consists of one or more parts.  
  A part is a connected sequence of two or more points. Parts may or may not be 
  connected to one another. Parts may or may not intersect one another.

  Because this specification does not forbid consecutive points with identical 
  coordinates, shapefile readers must handle such cases. On the other hand, the 
  degenerate, zero length parts that might result are not allowed.

  ## Examples

  """
  def parse_polyline(bytes) do
    parse_polygon(bytes)
  end

  @doc """
  A PointZ consists of a triplet of double-precision coordinates in the 
  order X, Y, Z plus a measure. The total size of a PointZ is 36 bytes.

  ## Examples

      iex> Shapefile.Shp.parse_pointz <<
      ...>   11, 0, 0, 0,
      ...>   0, 0, 0, 0, 0, 0, 0, 0,
      ...>   0, 0, 0, 0, 0, 0, 0, 0,
      ...>   0, 0, 0, 0, 0, 0, 0, 0,
      ...>   0, 0, 0, 0, 0, 0, 0, 0,
      ...> >>
      %{type: 11, x: 0.0, y: 0.0, z: 0.0, m: 0.0}

  """
  def parse_pointz(<<bytes::size(36)-binary>>) do
    <<
      type::unit(8)-size(@integer_byte_size)-little,
      x::unit(8)-size(@double_byte_size)-little-float,
      y::unit(8)-size(@double_byte_size)-little-float,
      z::unit(8)-size(@double_byte_size)-little-float,
      m::unit(8)-size(@double_byte_size)-little-float
    >> = bytes

    %{type: type, x: x, y: y, z: z, m: m}
  end

  @doc """
  Represents a set of pointz.

  ## Examples

      iex> file = File.read!("test/fixtures/multipointz.shp")
      iex> << _::size(108)-binary, content::binary >> = file
      iex> multipointz = Shapefile.Shp.parse_multipointz(content)
      iex> multipointz[:num_points] == 1
      true
      iex> multipointz[:type] == 18
      true

  """
  def parse_multipointz(bytes) do
    <<
      type::unit(8)-size(4)-little,
      box::unit(8)-size(32)-binary,
      num_points::unit(8)-size(4)-little,
      bytes::binary
    >> = bytes

    bbox = record_bbox(box)

    points_size = @point_byte_size * num_points
    zarray_size = @double_byte_size * num_points
    marray_size = @double_byte_size * num_points

    <<points_bytes::size(points_size)-binary, bytes::binary>> = bytes
    points = parse_points(points_bytes)

    <<
      zmin::unit(8)-size(8)-little-float,
      zmax::unit(8)-size(8)-little-float,
      zarray_bytes::size(zarray_size)-binary,
      mmin::unit(8)-size(8)-little-float,
      mmax::unit(8)-size(8)-little-float,
      marray_bytes::size(marray_size)-binary,
      _::binary
    >> = bytes

    # todo(heyzoos) check if m values are necessary

    %{
      type: type,
      box: bbox,
      num_points: num_points,
      points: points,
      zmin: zmin,
      zmax: zmax,
      zarray: parse_doubles(zarray_bytes, num_points),
      mmin: mmin,
      mmax: mmax,
      marray: parse_doubles(marray_bytes, num_points)
    }
  end

  @doc """
  Given a binary, convert it to a list of little endian doubles.
  
  ## Examples

      iex> Shapefile.Shp.parse_doubles(<<0, 0, 0, 0, 0, 0, 0, 0>>, 1)
      [0.0]

      iex> Shapefile.Shp.parse_doubles(<<0, 0, 0, 0, 0, 0, 0, 0>>, 0)
      []

  """
  def parse_doubles(bytes, count) do
    parse_doubles(bytes, count, [])
  end

  defp parse_doubles(_bytes, count, acc) when count <= 0, do: acc

  defp parse_doubles(bytes, count, acc) do
    <<double::unit(8)-size(8)-little-float, bytes::binary>> = bytes
    parse_doubles(bytes, count - 1, [double | acc])
  end

  @doc """
  Parse lists of points from a given binary with the given list of indices.
  A list of points is known as a part.

  ## Example

    iex> Shapefile.Shp.parse_point_parts([], <<>>)
    []

  """
  def parse_point_parts(indices, parts_bytes) do
    parse_point_parts(indices, parts_bytes, [])
  end

  defp parse_point_parts([], _, acc), do: acc

  defp parse_point_parts([_], parse_bytes, acc) do
    [parse_points(parse_bytes) | acc]
  end

  defp parse_point_parts(indices, parts_bytes, acc) do
    [start_i, stop_i] = Enum.take(indices, 2)
    [_ | indices] = indices
    point_len = (stop_i - start_i) * @point_byte_size
    <<part_bytes::size(point_len)-binary, parts_bytes::binary>> = parts_bytes
    part = parse_part(start_i, stop_i, part_bytes)
    parse_point_parts(indices, parts_bytes, [part | acc])
  end

  @doc """
  """
  def parse_part(curr_i, stop_i, part_bytes) do
    parse_part(curr_i, stop_i, part_bytes, [])
  end

  defp parse_part(curr_i, stop_i, _, acc) when curr_i == stop_i, do: acc

  defp parse_part(curr_i, stop_i, part_bytes, acc) do
    <<point_bytes::size(16)-binary, part_bytes::binary>> = part_bytes
    point = parse_point(point_bytes)
    parse_part(curr_i + 1, stop_i, part_bytes, [point | acc])
  end

  @doc """
  Extract points into a list of points from the given binary.

  ## Examples

  """
  def parse_points(points_bytes) do
    parse_points(points_bytes, [])
  end

  defp parse_points(<<>>, acc) do
    acc
  end

  defp parse_points(points_bytes, acc) do
    <<head::size(16)-binary, tail::binary>> = points_bytes
    parse_points(tail, [parse_point(head) | acc])
  end

  @doc """
  Parse an integer array that represents the indices of a polygon's parts.

  ## Example

      iex> Shapefile.Shp.parse_parts(<<1,0,0,0,1,0,0,0>>, 2)
      [1, 1]

      iex> Shapefile.Shp.parse_parts(<<1,0,0,0,1,0,0,0>>, 1)
      [1]

      iex> Shapefile.Shp.parse_parts(<<1,0,0,0,1,0,0,0>>, 0)
      []

  """
  def parse_parts(bytes, count) do
    parse_parts(bytes, count, [])
  end

  defp parse_parts(_bytes, 0, acc) do
    Enum.reverse(acc)
  end

  defp parse_parts(bytes, count, acc) do
    <<integer::unit(8)-size(4)-little, bytes::binary>> = bytes
    parse_parts(bytes, count - 1, [integer | acc])
  end

  @doc """
  Given a the file content of a .shp file, extract the records into a
  list of maps.

  ## Examples

      iex> shp = File.read!("test/fixtures/watersheds.shp")
      iex> << _ :: size(100)-binary, body::binary>> = shp
      iex> [ polygon | _ ] = Shapefile.Shp.parse_records(body)
      iex> polygon[:number] == 1
      true
      iex> polygon[:record][:num_points] == 900
      true

  """
  def parse_records(<<>>), do: []

  def parse_records(bytes) do
    <<head::size(8)-binary, bytes::binary>> = bytes
    %{number: number, length: len} = record_header(head)
    <<record::unit(16)-size(len)-binary, tail::binary>> = bytes
    [parse_record(number, record) | parse_records(tail)]
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
    <<head::unit(8)-size(100)-binary, body::binary>> = bytes

    %{
      header: header(head),
      records: parse_records(body)
    }
  end
end
