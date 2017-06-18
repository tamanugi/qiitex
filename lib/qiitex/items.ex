defmodule Qiitex.Items do
  import Qiitex

  def list(client) do
    get "/items", client
  end

  def find(client, item_id \\ "") do
    get "/items/#{item_id}", client
  end
end
