defmodule Wadus.Github do
  def org_repos(org_name) do
    task_pid = Task.async(fn -> get_org_repos(org_name) end)
    Task.await(task_pid)
  end

  defp get_org_repos(org_name) do
    HTTPotion.start
    case HTTPotion.get("https://api.github.com/orgs/#{org_name}/repos", [headers: ["User-Agent": "Wadus"]]) do
      %HTTPotion.Response{body: response, status_code: 200} ->
        Poison.decode!(response)
        |> Enum.map(&(&1["full_name"]))
      _ ->
        [] # Return empty list
    end
  end
end
