defmodule LaunchDarklyAPI.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :launch_darkly_api,
      version: @version,
      elixir: "~> 1.10",
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
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:dev, :test]},
      # Everything else
      {:hackney, "~> 1.17.0"},
      {:jason, "~> 1.0"},
      {:tesla, "~> 1.4.0"}
    ]
  end
end
