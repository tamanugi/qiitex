defmodule Qiitex.User do
  import Qiitex

  def authenticated_user(client) do
    get "/authenticated_user", client
  end

  @doc """
  List users who stocked an item in recent-stocked order.

  ## example

    ```
    Qiitex.Users.list_item_stockers client, "itemid"
    Qiitex.Users.list_item_stockers client, "itemid", %{page: 1, per_page: 40}
    ```
  """
  def list_item_stockers(client, item_id) do
    get "/items/#{item_id}/stockers", client
  end

  @doc """
  List users in newest order.

  ## example

    ```
    Qiitex.Users.list client
    Qiitex.Users.list client, %{page: 1, per_page: 40}
    ```
  """
  def list(client) do
    get "/users", client
  end

  @doc """
  Get a user.

  ## example

    ```
    Qiitex.Users.find client, "clientid"
    ```
  """
  def find(client, user_id) do
    get "/users/#{user_id}", client
  end

  @doc """
  List users a user is following

  ## example

    ```
    Qiitex.Users.followees client, "userid"
    Qiitex.Users.followees client, "userid", %{page: 1, per_page: 40}
    ```
  """
  def followees(client, user_id) do
    get "/users/#{user_id}/followees", client
  end

  @doc """
  List users who are following a user.

  ## example

    ```
    Qiitex.Users.followers client, "userid"
    Qiitex.Users.followers client, "userid", %{page: 1, per_page: 40}
    ```
  """
  def followers(client, user_id) do
    get "/users/#{user_id}/followers", client
  end

  @doc """
  Unfollow a user.

  ## example

    ```
    Qiitex.Users.unfollow client, "userid"
    ```
  """
  def unfollow(client, user_id) do
    delete "/users/#{user_id}/following", client
  end

  @doc """
  Check if the current user is following a user.

  ## example

    ```
    Qiitex.Users.get_follow client, "userid"
    ```
  """
  def get_follow(client, user_id) do
    get "/users/#{user_id}/following", client
  end

  @doc """
  Follow a user.

  ## example

    ```
    Qiitex.Users.follow client, "userid"
    ```
  """
  def follow(client, user_id) do
    put "users/#{user_id}/following", client
  end
end
