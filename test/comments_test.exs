defmodule Qiitex.CommentsTest do
  use ExUnit.Case
  import Qiitex.Comments
  alias Qiitex.TestHelper

  @client TestHelper.client
  @schema TestHelper.schema("comment")

  setup_all do
    HTTPoison.start
  end

  test "find/2" do

    comment = find(@client, "2dde107f6a0bcbf82edf")
    assert ExJsonSchema.Validator.validate(@schema, comment) == :ok
  end

  test "list_item_comments/2" do

    list_item_comments(@client, "5bbf6ef210273cf60dd4")
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

end
