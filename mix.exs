defmodule Qiitex.Mixfile do
  use Mix.Project

  def project do
    [app: :qiitex,
     version: "1.0.0",
     elixir: "~> 1.4",
     description: "Simple API wrapper for Qiita API v2",
     package: [
       maintainers: ["tamanugi"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/tamanugi/qiitex"}
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [applications: [:httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~>0.11"},
      {:poison, "~>3.1"},
      {:ex_json_schema, "~> 0.5.4"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev}
    ]
  end
end
