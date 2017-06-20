defmodule Qiitex.UserTest do
  use ExUnit.Case
  import Qiitex.User
  alias Qiitex.TestHelper

  @client Qiitex.Client.new(%{access_token: "enteryouraccesstoken"})
  @schema TestHelper.schema("user")

  setup_all do
    HTTPoison.start
  end

  test "authenticated_user/1" do
    user = authenticated_user(@client)
    assert ExJsonSchema.Validator.validate(@schema , user) == :ok
    assert user["id"] == "tamanugi"
  end
end
