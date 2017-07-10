defmodule Qiitex.Tags do
  import Qiitex

  def list(client, params \\ []) do
    get "/tags", client, params
  end

  def find(client, tag_id \\ "") do
    get "/tags/#{tag_id}", client
  end

  def user_following(client, user_id, params \\ []) do
    get "/users/#{user_id}/following_tags", client, params
  end

  def follow(client, tag_id) do
    put "/tags/#{tag_id}/following", client
  end
  
  def unfollow(client, tag_id) do
    delete "/tags/#{tag_id}/following", client
  end

  def get_tag_following(client, tag_id) do
    get "/tags/#{tag_id}/following", client
  end

end
