defmodule Qiitex.User do
  import Qiitex

  def authenticated_user(client) do
    get "/authenticated_user", client
  end

  def list_item_stockers(client, item_id) do
    get "/items/#{item_id}/stockers", client
  end

  def list(client) do
    get "/users", client
  end

  def find(client, user_id) do
    get "/users/#{user_id}", client
  end

  def followees(client, user_id) do
    get "/users/#{user_id}/followees", client
  end

  def followers(client, user_id) do
    get "/users/#{user_id}/followers", client
  end

  def unfollow(client, user_id) do
    delete "/users/#{user_id}/following", client
  end

  def get_follow(client, user_id) do
    get "/users/#{user_id}/following", client
  end

  def follow(client, user_id) do
    put "users/#{user_id}/following", client
  end
end
