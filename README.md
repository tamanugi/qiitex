# Qiitex

Simple Elixir wrapper for the [Qiita v2 API](https://qiita.com/api/v2/docs).

Based heavily on the [Tentacat](https://github.com/edgurgel/tentacat) libraries

## Usage

```elixir
iex> client = Qiitex.client.new()
iex> Qiitex.Tags.list client
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `qiitex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:qiitex, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/qiitex](https://hexdocs.pm/qiitex).

