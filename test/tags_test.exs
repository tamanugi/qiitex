defmodule Qiitex.TagsTest do
    use ExUnit.Case
    import Qiitex.Tags

    @client Qiitex.Client.new

    setup_all do
        HTTPoison.start
    end

    test "tags/1" do

        %HTTPoison.Response{body: body} = HTTPoison.get! "http://qiita.com/api/v2/schema?locale=en"
        schema = body
        |> Poison.decode!
        |> Map.get("properties")
        |> Map.get("tag")

        tags(@client)
        |> Enum.each(fn(e) -> assert :ok = ExJsonSchema.Validator.validate(schema , e) end)
        
    end
end
