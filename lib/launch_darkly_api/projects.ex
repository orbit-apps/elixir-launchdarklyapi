defmodule LaunchDarklyAPI.Projects do
  alias LaunchDarklyAPI.Request
  def list, do: Request.get("projects")
end
