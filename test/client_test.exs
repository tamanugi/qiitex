defmodule Qiitex.ClientTest do
  use ExUnit.Case
  import Qiitex.Client

  doctest Qiitex.Client

  test "default endpoint" do
    client = new(%{})
    assert client.endpoint == "https://qiita.com/"
  end

  test "access token" do
    client = new(%{access_token: "enteryouraccesstoken"})
    assert client.auth == %{access_token: "enteryouraccesstoken"}
  end
end
