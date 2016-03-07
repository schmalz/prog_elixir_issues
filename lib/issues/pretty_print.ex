defmodule Issues.PrettyPrint do

  @doc """
  Pretty prints columns of data from `rows`.
  """
  def print_table_for_columns(rows, headers) do
    columns = split_into_columns(rows, headers)
    widths = widths_of(columns)
    format = format_for(widths)
    puts_fields_in_columns(headers, format)
    IO.puts(separator(widths))
    puts_in_columns(columns, format)
  end

  defp split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  defp printable(str) when is_binary(str), do: str

  defp printable(str), do: to_string(str)

  defp widths_of(columns), do: for column <- columns, do: column |> Enum.map(&String.length/1) |> Enum.max

  defp format_for(widths), do: Enum.map_join(widths, " | ", fn width -> "~-#{width}s" end) <> "~n"

  defp separator(widths), do: Enum.map_join(widths, "-+-", fn width -> List.duplicate("-", width) end)

  defp puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_fields_in_columns(&1, format))
  end

  defp puts_fields_in_columns(fields, format), do: :io.format(format, fields)
end
