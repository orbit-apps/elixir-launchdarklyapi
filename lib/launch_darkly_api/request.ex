defmodule LaunchDarklyAPI.Request do
  use HTTPoison.Base
  require Logger

  alias HTTPoison.{AsyncResponse, Error, Response}

  @http_receive_timeout 1000
  @transport "https://"
  @domain "app.launchdarkly.com"

  @spec get(String.t()) :: {:ok, Response.t() | AsyncResponse.t()} | {:error, Error.t()}
  def get(path), do: ld_request(:get, url(path), "", headers())

  @spec put(String.t(), map()) :: {:ok, Response.t() | AsyncResponse.t()} | {:error, Error.t()}
  def put(path, object), do: ld_request(:put, url(path), Jason.encode!(object), headers())

  @spec post(String.t(), map()) :: {:ok, Response.t() | AsyncResponse.t()} | {:error, Error.t()}
  def post(path, object \\ %{}),
    do: ld_request(:post, url(path), Jason.encode!(object), headers())

  @spec delete(String.t()) :: {:ok, Response.t() | AsyncResponse.t()} | {:error, Error.t()}
  def delete(path), do: ld_request(:delete, url(path), "", headers())

  defp ld_request(action, url, body, headers) do
    Logger.debug("#{__MODULE__} requesting #{inspect(url)}")

    case request(action, url, body, headers, recv_timeout: @http_receive_timeout) do
      {:ok, %{status_code: status} = response} when status >= 200 and status < 300 ->
        {:ok, fetch_body(response)}

      {:ok, response} ->
        {:error, response}

      response ->
        {:error, response}
    end
  end

  def process_response_body(body) when byte_size(body) == 0, do: %{}
  def process_response_body(body), do: Jason.decode(body)

  defp url(path), do: "#{@transport}#{@domain}/api/v2/#{path}"

  defp headers do
    access_token = Application.get_env(:launch_darkly_api, :authorization)[:access_token]

    [
      {"Content-Type", "application/json"},
      {"Authorization", access_token}
    ]
  end

  defp fetch_body(http_response) do
    with {:ok, map_fetched} <- Map.fetch(http_response, :body),
         {:ok, body} <- map_fetched,
         do: body
  end
end
