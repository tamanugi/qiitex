defmodule QiitexTest do
  use ExUnit.Case
  import Qiitex

  doctest Qiitex

  test "authorization_header using access token" do
    assert authorization_header(%{access_token: "9820103"}, []) == [{"Authorization", "Bearer 9820103"}]
  end

  test "process response on a 200 response" do
    assert process_response(%HTTPoison.Response{ status_code: 200,
                                                 headers: %{},
                                                 body: "json" }) == "json"
  end

  test "process response on a non-200 response" do
    assert process_response(%HTTPoison.Response{ status_code: 404,
                                                 headers: %{},
                                                 body: "json" }) == "json"
  end

end
