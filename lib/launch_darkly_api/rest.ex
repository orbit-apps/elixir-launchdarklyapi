defmodule LaunchDarklyAPI.REST do
  alias LaunchDarklyAPI.Request

  @type response :: map()
  @type error :: HTTPoison.Error.t()

  @spec get(String.t()) :: {:ok, response()} | {:error, error()}
  def get(path), do: Request.perform(:get, path, "")

  @spec put(String.t(), map()) :: {:ok, response()} | {:error, error()}
  def put(path, object), do: Request.perform(:put, path, Jason.encode!(object))

  @spec post(String.t(), map()) :: {:ok, response()} | {:error, error()}
  def post(path, object \\ %{}), do: Request.perform(:post, path, Jason.encode!(object))

  @spec delete(String.t()) :: {:ok, response()} | {:error, error()}
  def delete(path), do: Request.perform(:delete, path, "")
end
