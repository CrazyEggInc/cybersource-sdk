defmodule CyberSourceSDK.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cybersource_sdk,
      version: "1.0.5",
      elixir: "~> 1.18",
      deps: deps(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: [
        maintainers: ["David Magalhães"],
        licenses: ["MIT"],
        links: %{github: "https://github.com/coletiv/cybersource-sdk"}
      ],
      description: """
      Non-official library used to call WSDL SOAP Services of CyberSource.
      """,

      # Docs
      name: "CyberSource SDK",
      source_url: "https://github.com/coletiv/cybersource-sdk",
      docs: [
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      mod: {CyberSourceSDK, []}
    ]
  end

  defp deps do
    [
      {:sweet_xml, "~> 0.7"},
      {:req, "~> 0.5"},
      {:cowboy, "~> 2.12"},
      {:plug_cowboy, "~> 2.7"},
      {:ex_doc, "~> 0.37", only: :dev, runtime: false},
      {:bypass, "~> 2.1", only: :test},
      {:exvcr, "~> 0.15", only: :test}
    ]
  end
end
