defmodule Translit.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :translit,
      description: "Cyrillic ukrainian to latin transliteration",
      package: package(),
      version: @version,
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [
      contributors: ["edenlabllc"],
      maintainers: ["edenlabllc"],
      licenses: ["LISENSE.md"],
      links: %{github: "https://github.com/edenlabllc/translit"},
      files: ~w(lib LICENSE.md mix.exs README.md)
    ]
  end
end
