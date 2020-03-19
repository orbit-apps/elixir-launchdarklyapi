defmodule LaunchDarklyAPI.Users do
  alias LaunchDarklyAPI.REST

  def list(project_key, env_key, params \\ %{}),
    do: REST.get("users/#{project_key}/#{env_key}?" <> URI.encode_query(params))
end
