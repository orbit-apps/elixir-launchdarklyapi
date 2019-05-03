defmodule LaunchDarklyAPI.Users do
  alias LaunchDarklyAPI.Request

  def list(project_key, env_key, params \\ %{}),
    do: Request.get("users/#{project_key}/#{env_key}?" <> URI.encode_query(params))
end
