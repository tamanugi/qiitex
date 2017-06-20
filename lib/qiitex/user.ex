defmodule Qiitex.User do
  import Qiitex

  def authenticated_user(client) do
    get "/authenticated_user", client
  end
end
