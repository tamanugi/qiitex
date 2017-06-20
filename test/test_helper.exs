ExUnit.start()

defmodule Qiitex.TestHelper do

  @json_schema_url "http://qiita.com/api/v2/schema?locale=en"

  def schema(api_name \\ "") do
    %HTTPoison.Response{body: body} = HTTPoison.get! @json_schema_url
    schema = body
    |> Poison.decode!
    |> Map.get("properties")
    |> Map.get(api_name)

    schema
  end

  def client do
    Qiitex.Client.new(%{access_token: ""})
  end
end
