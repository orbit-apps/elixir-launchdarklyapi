defmodule LaunchDarklyAPI.REST do
  require Logger

  @type response :: map()

  @http_receive_timeout 1000
  @base_url "https://app.launchdarkly.com"

  @spec get(String.t()) :: {:ok, response()} | {:error, any()}
  def get(path), do: perform(:get, path)

  @spec put(String.t(), map()) :: {:ok, response()} | {:error, any()}
  def put(path, object), do: perform(:put, path, object)

  @spec post(String.t(), map()) :: {:ok, response()} | {:error, any()}
  def post(path, object \\ %{}), do: perform(:post, path, object)

  @spec delete(String.t()) :: {:ok, response()} | {:error, any()}
  def delete(path), do: perform(:delete, path)

  @spec perform(atom(), String.t(), map() | nil) :: {:ok, map()} | Tesla.Env.result()
  def perform(method, path, body \\ nil) do
    path = full_path(path)
    Logger.debug("#{__MODULE__} requesting #{path}")

    case Tesla.request(client(), method: method, url: path, body: body) do
      {:ok, %{status: status} = response} when status >= 200 and status < 300 ->
        {:ok, Map.get(response, :body, %{})}

      {:ok, response} ->
        {:error, response}

      response ->
        response
    end
  end

  defp full_path(path), do: "/api/v2/#{path}"

  # build dynamic client based on runtime arguments
  defp client do
    middleware = [
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Timeout, [timeout: @http_receive_timeout]},
      {Tesla.Middleware.Headers, [{"authorization", token()}]}
    ]

    Tesla.client(middleware)
  end

  defp token, do: Application.get_env(:launch_darkly_api, :authorization)[:access_token]
end
