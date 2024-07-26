defmodule LaunchDarklyAPI.ContextSettings do
  alias LaunchDarklyAPI.REST

  def list(project_key, env_key, context_kind, context_key) do
    REST.post(
      "projects/#{project_key}/environments/#{env_key}/flags/evaluate",
      %{key: context_key, kind: context_kind}
    )
  end

  def update(project_key, env_key, context_kind, context_key, feature_key, values) do
    REST.put(
      "projects/#{project_key}/environments/#{env_key}/contexts/#{context_kind}/#{context_key}/flags/#{feature_key}",
      values
    )
  end

  def enable(project_key, env_key, context_kind, context_key, feature_key),
    do: update(project_key, env_key, context_kind, context_key, feature_key, %{setting: true})

  def disable(project_key, env_key, context_kind, context_key, feature_key),
    do: update(project_key, env_key, context_kind, context_key, feature_key, %{setting: false})
end
