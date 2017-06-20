defmodule Qiitex.ItemsTest do
  use ExUnit.Case
  import Qiitex.Items
  alias Qiitex.TestHelper

  @client TestHelper.client
  @schema TestHelper.schema("item")

  setup_all do
    HTTPoison.start
  end

  test "list/2 without params" do

    list(@client)
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

  test "list/2" do
    list(@client, %{query: "qiita user:tamanugi"})
    |> Enum.each(fn(e) ->
      assert get_in(e, ["user", "id"]) == "tamanugi"
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

  test "find/2" do
    item = find(@client, "5bbf6ef210273cf60dd4")
    assert ExJsonSchema.Validator.validate(@schema , item) == :ok
    assert item |> Map.get("title") == "QIITA API TEST ARTICLE"
  end

  test "list_tag_items/3" do
    list_tag_items(@client, "Elixir")
    |> Enum.each(fn(e) ->
      assert e |> Map.get("tags") |> Enum.any?(&(&1 |> Map.get("name") == "Elixir"))
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

  test "list_user_items/3" do
    list_user_items(@client, "tamanugi")
    |> Enum.each(fn(e) ->
      assert get_in(e, ["user", "id"]) == "tamanugi"
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

  test "list_user_stock_items/3" do
    list_user_stock_items(@client, "tamanugi")
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end
end
