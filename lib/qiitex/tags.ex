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
end
