defmodule Qiitex.Emoji do
  import Qiitex

  def reaction_comment(client, comment_id, params) do
    post "/comments/#{comment_id}/reactions", client, params
  end

  def reaction_item(client, item_id, params) do
    post "/items/#{item_id}/reactions", client, params
  end

  def remove_reaction_comment(client, comment_id, reaction_name) do
    delete "/comments/#{comment_id}/reactions/#{reaction_name}", client
  end
    
  def remove_reaction_item(client, item_id, reaction_name) do
    delete "/items/#{item_id}/reactions/#{reaction_name}", client
  end

  def list_reactions_comment(client, comment_id) do
    get "/comments/#{comment_id}/reactions", client
  end

  def list_reactions_item(client, item_id) do
    get "/comments/#{item_id}/reactions", client
  end
end