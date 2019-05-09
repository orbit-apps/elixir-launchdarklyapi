defmodule LaunchDarklyAPI.MixProject do
  use Mix.Project

  def project do
    [
      app: :launch_darkly_api,
      version: "0.1.2",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dev
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:dev, :test]},
      # Everything else
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.0"}
    ]
  end
end
