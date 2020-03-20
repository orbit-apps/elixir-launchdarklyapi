defmodule LaunchDarklyAPI.Projects do
  alias LaunchDarklyAPI.REST
  def list, do: REST.get("projects")
end
