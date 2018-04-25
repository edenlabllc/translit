defmodule Translit.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :translit,
      description: "Cyrillic ukrainian to latin transliteration",
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  # Settings for publishing in Hex package manager:
  defp package do
    [contributors: ["edenlabllc"],
      maintainers: ["edenlabllc"],
      licenses: ["LISENSE.md"],
      links: %{github: "https://github.com/edenlabllc/translit"},
      files: ~w(lib LICENSE.md mix.exs README.md)]
  end
end
