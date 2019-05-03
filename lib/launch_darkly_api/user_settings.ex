defmodule LaunchDarklyAPI.UserSettings do
  alias LaunchDarklyAPI.Request

  def list(project_key, env_key, user_key),
    do: Request.get("users/#{project_key}/#{env_key}/#{user_key}/flags")

  def get(project_key, env_key, user_key, feature_key),
    do: Request.get("users/#{project_key}/#{env_key}/#{user_key}/flags/#{feature_key}")

  def update(project_key, env_key, user_key, feature_key, values),
    do: Request.get("users/#{project_key}/#{env_key}/#{user_key}/flags/#{feature_key}", values)

  def enable(project_key, env_key, user_key, feature_key),
    do: update(project_key, env_key, user_key, feature_key, %{settings: true})

  def disable(project_key, env_key, user_key, feature_key),
    do: update(project_key, env_key, user_key, feature_key, %{settings: false})
end
