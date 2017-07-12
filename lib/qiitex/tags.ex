defmodule Qiitex.Tags do
  import Qiitex


  @doc """
  List tags in newest order.
  
  ## Example

    ```
    Qiitex.Tags.list client
    Qiitex.Tags.list client, %{page: 1, per_page: 30, sort: "count"}
    ```
  """
  def list(client, params \\ []) do
    get "/tags", client, params
  end


  @doc """
  Get a tag.
  
  ## Example

    ```
    Qiitex.Tags.find client, "tagid"
    ```
  """
  def find(client, tag_id) do
    get "/tags/#{tag_id}", client
  end

  @doc """
  List tags a user is following to in recently-tagged order 

  ## Example

    ```
    Qiitex.Tags.user_following client, "userid"
    Qiitex.Tags.user_following client, "userid", %{page: 1, per_page: 40}
    ```
  """
  def user_following(client, user_id, params \\ []) do
    get "/users/#{user_id}/following_tags", client, params
  end

  @doc """
  Follow a tag.

  ## Example

    ```
    Qiitex.Tags.follow client, "tagid"
    ```
  """
  def follow(client, tag_id) do
    put "/tags/#{tag_id}/following", client
  end
  
  @doc """
  unfollow a tag.

  ## example

    ```
    Qiitex.Tags.unfollow client, "tagid"
    ```
  """
  def unfollow(client, tag_id) do
    delete "/tags/#{tag_id}/following", client
  end


  @doc """
  Check if you are following a tag or not.

  ## example

    ```
    Qiitex.Tags.get_tag_following client, "tagid"
    ```
  """
  def get_tag_following(client, tag_id) do
    get "/tags/#{tag_id}/following", client
  end

end
