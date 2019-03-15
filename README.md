# Qiitex

[![hex.pm version](https://img.shields.io/hexpm/v/qiitex.svg)](https://hex.pm/packages/qiitex)

Simple Elixir wrapper for the [Qiita v2 API](https://qiita.com/api/v2/docs).

Generate from [Qiita API v2 JSON Schema](https://qiita.com/api/v2/schema)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `qiitex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:qiitex, "~> 1.0.0"}]
end
```

## Usage

Get access token [here](https://qiita.com/settings/tokens/new) 

```elixir
iex> client = Qiitex.Client.new %{access_token: "enteryouraccesstoken"}
iex> Qiitex.Api.Tag.list_tags client
{:ok,
 [
   %{
     "followers_count" => 0,
     "icon_url" => nil,
     "id" => "eclair-labo",
     "items_count" => 0
   },
   %{
     "followers_count" => 0,
     "icon_url" => nil,
     "id" => "fake-hwclock",
     "items_count" => 1
   },
   ...
iex> Qiitex.Items.create client, %{title: "title", body: "body", tags: [%{name: "qiita"}]}
```

-------------------------------------------
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/qiitex](https://hexdocs.pm/qiitex).

