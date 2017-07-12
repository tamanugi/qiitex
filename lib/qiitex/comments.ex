defmodule Qiitex.Comments do
  import Qiitex

  @doc """
  Get a commnet.

  ## Example
    
    ```
    Qiitex.Comments.find client, "comment_id"
    ```
  
  """
  def find(client, comment_id \\ "") do
    get "/comments/#{comment_id}", client
  end

  @doc """
  List comments on an item in newest order

  ## Example

    ```
    Qiitex.Comments.list_item_comments client, "item_id"
    ```

  """
  def list_item_comments(client, item_id \\ "") do
    get "/items/#{item_id}/comments", client
  end

  @doc """
  Delete a comment.

  ## Example
    
    ```
    Qiitex.Comments.delete_comment client, "commentid"
    ```
    
  """
  def delete_comment(client, comment_id) do
    delete "/comments/#{comment_id}", client
  end

  @doc """
  Update a comment.

  ## Example

    ```
    Qiitex.Comments.update_comment client, "commentid", %{body: "# test"}
    ```
  
  """
  def update_comment(client, comment_id ,param) do
    patch "/comments/#{comment_id}", client, param
  end


  @doc """
  Post a comment on an item.

  ## Example

    ```
    Qiitex.Comments.create_comment client, "itemid", %{body: "# test"}
    ```

  """
  def create_comment(client, item_id, param) do
    post "/items/#{item_id}/comments", client, param
  end
end
