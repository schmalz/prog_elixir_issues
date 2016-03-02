defmodule Issues.GithubIssues do

  @github_url Application.get_env(:issues, :github_url)
  @user_agent [{"User-agent", "Elixir schmalz"}]

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

  defp handle_response({:error, %{id: id, reason: reason}}), do: {:error, {id, reason}}
end
