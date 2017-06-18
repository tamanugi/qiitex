defmodule Qiitex.TagsTest do
    use ExUnit.Case
    import Qiitex.Tags
    alias Qiitex.Schema.SchemaHelper

    @client Qiitex.Client.new

    setup_all do
        HTTPoison.start
    end

    test "list/1" do

        list(@client)
        |> Enum.each(fn(e) ->
          assert ExJsonSchema.Validator.validate(SchemaHelper.schema("tag") , e) == :ok
        end)
    end

    test "find/2" do
        tag = find(@client, "elixir")
        assert ExJsonSchema.Validator.validate(SchemaHelper.schema("tag") , tag) == :ok
        assert tag == %{"followers_count" => 902,
                       "icon_url" => "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/6e0b49c8d70cd06c57386d923a8362fbaf71c233/medium.jpg?1364840830",
                       "id" => "Elixir", "items_count" => 883}
    end
end
