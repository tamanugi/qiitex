defmodule Qiitex.UserTest do
  use ExUnit.Case
  import Qiitex.User
  alias Qiitex.TestHelper

  @client TestHelper.client
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
