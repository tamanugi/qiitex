defmodule Qiitex.CommentsTest do
  use ExUnit.Case
  alias Qiitex.Api.Comment
  alias Qiitex.TestHelper

  @client TestHelper.client
  @schema TestHelper.schema("comment")

  setup_all do
    HTTPoison.start
  end

  test "find/2" do

    comment = Comment.get_comment(@client, "2dde107f6a0bcbf82edf")
    assert ExJsonSchema.Validator.validate(@schema, comment) == :ok
  end

  test "list_item_comments/2" do

    Comment.list_item_comments(@client, "5bbf6ef210273cf60dd4")
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

end
