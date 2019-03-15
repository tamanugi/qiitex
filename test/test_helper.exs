ExUnit.start()

defmodule Qiitex.TestHelper do

  @json_schema_url "https://qiita.com/api/v2/schema?locale=en"

  def schema(api_name \\ "") do
    HTTPoison.get!(@json_schema_url)
    |> Map.fetch!(:body)
    |> Poison.decode!
    |> Map.get("properties")
    |> Map.get(api_name)
  end

  def client do
    Qiitex.Client.new(%{access_token: ""})
  end
end
