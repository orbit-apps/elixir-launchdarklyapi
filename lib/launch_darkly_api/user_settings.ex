defmodule LaunchDarklyAPI.UserSettings do
  alias LaunchDarklyAPI.REST

  def list(project_key, env_key, user_key),
    do: REST.get("users/#{project_key}/#{env_key}/#{user_key}/flags")

  def get(project_key, env_key, user_key, feature_key),
    do: REST.get("users/#{project_key}/#{env_key}/#{user_key}/flags/#{feature_key}")

  def update(project_key, env_key, user_key, feature_key, values),
    do: REST.put("users/#{project_key}/#{env_key}/#{user_key}/flags/#{feature_key}", values)

  def enable(project_key, env_key, user_key, feature_key),
    do: update(project_key, env_key, user_key, feature_key, %{setting: true})

  def disable(project_key, env_key, user_key, feature_key),
    do: update(project_key, env_key, user_key, feature_key, %{setting: false})
end
