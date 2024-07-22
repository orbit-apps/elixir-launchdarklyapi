defmodule LaunchDarklyAPI.MixProject do
  use Mix.Project

  @version "0.2.3"

  def project do
    [
      app: :launch_darkly_api,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix, :ex_unit],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
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
      {:credo, "~> 1.7", only: [:dev, :test]},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      # Everything else
      {:hackney, "~> 1.20.1"},
      {:jason, "~> 1.4"},
      {:tesla, "~> 1.11"}
    ]
  end
end
