defmodule Qiitex.Items do
  import Qiitex

  def list(client, params \\ []) do
    get "/items", client, params
  end

  def find(client, item_id \\ "") do
    get "/items/#{item_id}", client
  end

  def list_tag_items(client, tag_id \\ "", params \\ []) do
    get "/tags/#{tag_id}/items", client, params
  end
end
