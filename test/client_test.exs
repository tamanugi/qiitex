defmodule Qiitex.ClientTest do
  use ExUnit.Case
  import Qiitex.Client

  doctest Qiitex.Client

  test "default endpoint" do
    client = new(%{})
    assert client.endpoint == "https://qiita.com/api/v2/"
  end
end