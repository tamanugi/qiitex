defmodule Qiitex.ItemsTest do
  use ExUnit.Case
  import Qiitex.Items
  alias Qiitex.Schema.SchemaHelper

  @client Qiitex.Client.new

  @schema SchemaHelper.schema("item")

  setup_all do
    HTTPoison.start
  end

  test "list/2 without params" do

    list(@client)
    |> Enum.each(fn(e) ->
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
    item = find(@client, "43bad0158f4a4bb7d1d2")
    assert ExJsonSchema.Validator.validate(@schema , item) == :ok
  end
end
