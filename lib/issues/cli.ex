defmodule Issues.Cli do

  @default_count 4

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(argv) do
    case OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help]) do
      {[help: true], _, _} -> :help
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
      {_, [user, project], _} -> {user, project, @default_count}
      _ -> :help
    end
  end

  defp process(:help) do
    IO.puts("""
    usage: issues <user> <project> [count|#{@default_count}]
    """)
    System.halt(0)
  end

  defp process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> Issues.PrettyPrint.print_table_for_columns(["number", "created_at", "title"])
  end

  defp decode_response({:ok, body}), do: body

  defp decode_response({:error, error}) do
    message = error["message"]
    IO.puts("Error fetching from GitHub: #{message}")
    System.halt(2)
  end

  defp sort_into_ascending_order(issues) do
    Enum.sort(issues, fn(this, that) -> this["created_at"] <= that["created_at"] end)
  end
end
