defmodule Issues.GithubIssues do

  @user_agent [{"User-agent", "Elixir plong@radiantworlds.com"}]

  def fetch(user, project) do
    url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  defp url(user, project), do: "https://api.github.com/repos/#{user}/#{project}/issues"

  defp handle_response({:ok, %{status_code: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %{status_code: _, body: body}}), do: {:error, body}

  defp handle_response({:error, %{body: body}}), do: {:error, body}
end
