defmodule Qiitex.Comments do
  import Qiitex

  def find(client, comment_id \\ "") do
    get "/comments/#{comment_id}", client
  end

  def list_item_comments(client, item_id \\ "") do
    get "/items/#{item_id}/comments", client
  end

  def delete_comment(client, comment_id) do
    delete "/comments/#{comment_id}", client
  end
end
