# LaunchDarklyAPI

Launch Darkly API library.

WARNING: Not complete.

## Installation

```elixir
def deps do
  [
    {:launch_darkly_api, github: "pixelunion/elixir-launchdarklyapi", tag: "v0.2.1"}
  ]
end
```

## Configuration

Add the following to your `config/prod.exs`


```elixir
config :launch_darkly_api, :authorization,
  access_token: System.get_env("LAUNCH_DARKLY_API_KEY")

config :launch_darkly_api, :environment, "production"
```
