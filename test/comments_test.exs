defmodule Qiitex.CommentsTest do
  use ExUnit.Case
  alias Qiitex.Api.Comment
  alias Qiitex.TestHelper

  @client TestHelper.client
  @schema TestHelper.schema("comment")

  setup_all do
    HTTPoison.start
  end

  test "not found comment" do

    {:error, error} = Comment.get_comment(@client, "hogehogehoge")
    assert is_map error
    assert error["message"] == "Not found"
  end

  test "list_item_comments/2" do

    {:ok, comments} = Comment.list_item_comments(@client, "5bbf6ef210273cf60dd4")

    comments
    |> Enum.each(fn(e) ->
      assert is_map e
      assert ExJsonSchema.Validator.validate(@schema , e) == :ok
    end)
  end

end
