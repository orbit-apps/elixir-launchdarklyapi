defmodule LaunchDarklyAPI.Request do
  use HTTPoison.Base
  require Logger

  @http_receive_timeout 1000
  @transport "https://"
  @domain "app.launchdarkly.com"

  def perform(action, path, body) do
    url = url(path)
    Logger.debug("#{__MODULE__} requesting #{inspect(url)}")

    case request(action, url, body, headers(), recv_timeout: @http_receive_timeout) do
      {:ok, %{status_code: status} = response} when status >= 200 and status < 300 ->
        {:ok, Map.get(response, :body, %{})}

      {:ok, response} ->
        {:error, response}

      response ->
        {:error, response}
    end
  end

  def process_response_body(body) when byte_size(body) == 0, do: %{}
  def process_response_body(body), do: Jason.decode!(body)

  defp url(path), do: "#{@transport}#{@domain}/api/v2/#{path}"

  defp headers do
    access_token = Application.get_env(:launch_darkly_api, :authorization)[:access_token]

    [
      {"Content-Type", "application/json"},
      {"Authorization", access_token}
    ]
  end
end
