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

  def list_user_items(client, user_id \\ "", params \\ []) do
    get "/users/#{user_id}/items", client, params
  end

  def list_user_stock_items(client, user_id \\ "", params \\ []) do
    get "/users/#{user_id}/stocks", client, params
  end

  def list_authenticated_user_items(client, params \\ []) do
    get "/authenticated_user/items", client, params
  end

  def create(client, params) do
    post "/items", client, params
  end

  def delete_item(client, item_id) do
    delete "/items/#{item_id}", client
  end

  def update(client, item_id, params) do
    patch "/items/#{item_id}", client, params
  end

  def stock(client, item_id) do
    put "/items/#{item_id}/stock", client
  end

  def unstock(client, item_id) do
    delete "/items/#{item_id}/stock", client
  end

  def get_stock(client, item_id) do
    get "/items/#{item_id}/stock", client
  end

end
