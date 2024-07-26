defmodule LaunchDarklyAPI.FeatureFlag.UserFlag do
  alias LaunchDarklyAPI.UserSettings

  require Logger

  defstruct environment: "staging", feature: "", project: "", user: "", value: false

  @type t :: %__MODULE__{
          environment: String.t(),
          feature: String.t(),
          project: String.t(),
          user: String.t(),
          value: boolean
        }

  @default_env "staging"

  @spec all(String.t(), String.t()) :: list()
  def all(project, user) do
    case UserSettings.list(project, get_env(), user) do
      {:ok, %{"items" => flags}} ->
        Enum.map(flags, fn {k, %{"setting" => v}} -> new(project, user, k, v == true) end)

      _ ->
        []
    end
  end

  @spec update(__MODULE__.t()) :: {:ok | :error, any()}
  def update(feature_flag) do
    Logger.info("#{__MODULE__}.update/1 called with #{inspect(feature_flag)}")

    update_func =
      case feature_flag.value do
        true -> &UserSettings.enable/4
        false -> &UserSettings.disable/4
      end

    update_func.(
      feature_flag.project,
      feature_flag.environment,
      feature_flag.user,
      feature_flag.feature
    )
  end

  @spec new(String.t(), String.t(), String.t(), boolean) :: __MODULE__.t()
  def new(project, user, key, value) do
    %__MODULE__{
      environment: get_env(),
      feature: key,
      project: project,
      user: user,
      value: value
    }
  end

  @spec get_env() :: String.t()
  def get_env, do: Application.get_env(:launch_darkly_api, :environment, @default_env)
end
