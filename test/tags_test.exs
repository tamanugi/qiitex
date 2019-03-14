defmodule Qiitex.TagsTest do
  use ExUnit.Case
  import Qiitex.Api.Tag
  alias Qiitex.TestHelper

  @client TestHelper.client
  @schema TestHelper.schema("tag")

  setup_all do
    HTTPoison.start
  end

  test "list/2" do

    list_tags(@client)
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

  test "find/2" do
    tag = list_tags(@client, "elixir")
    assert ExJsonSchema.Validator.validate(@schema , tag) == :ok
    %{"icon_url" => icon_url,
      "id" => id} = tag

    assert icon_url  == "https://s3-ap-northeast-1.amazonaws.com/qiita-tag-image/6e0b49c8d70cd06c57386d923a8362fbaf71c233/medium.jpg?1364840830"
    assert id == "Elixir"
  end

  test "user_following/3" do
    list_user_following_tags(@client, "tamanugi")
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end
end
