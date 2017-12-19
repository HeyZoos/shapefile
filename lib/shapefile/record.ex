defmodule Shapefile.Record do

    def number(bytes) do
        << num :: unit(8)-size(4)-big >> = bytes
        num
    end

    def length(bytes) do
        << _ :: unit(8)-size(4), len :: unit(8)-size(4)-big >> = bytes
        len
    end

    def header(bytes) do
        %{
            number: number(bytes),
            length: length(bytes)
        }
    end
end