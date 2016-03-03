defmodule Issues.GithubIssues do

  @github_url Application.get_env(:issues, :github_url)
  @user_agent [{"User-agent", "Elixir schmalz"}]

  @doc"""
  Fetches the issues from the GitHub `project` belonging to `user`.
  """
  def fetch(user, project) do
    url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp url(user, project), do: "#{@github_url}/repos/#{user}/#{project}/issues"

  defp handle_response({:ok, %{status_code: 200, body: body}}), do: Poison.decode(body)

  defp handle_response({:ok, %{status_code: _, body: body}}) do
    {_, data} = Poison.decode(body)
    {:error, data}
  end

  defp handle_response({:error, %{reason: reason}}), do: {:error, %{"message" => reason}}
end
