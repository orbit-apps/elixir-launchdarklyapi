defmodule LaunchDarklyAPI.FeatureFlags do
  alias LaunchDarklyAPI.Request
  def list(project_key), do: Request.get("flags/#{project_key}")

  def get(project_key, feature_key, params \\ %{}),
    do: Request.get("flags/#{project_key}/#{feature_key}?" <> URI.encode_query(params))
end
