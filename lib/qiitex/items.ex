defmodule Qiitex.Items do
  import Qiitex

  def list(client, params \\ []) do
    get "/items", client, params
  end

  def find(client, item_id \\ "") do
    get "/items/#{item_id}", client
  end
end
