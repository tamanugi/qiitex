defmodule Qiitex.Items do
  import Qiitex

  @doc """
  List items.

  ## Example
    
    ```
    Qiitex.Items.list client
    Qiitex.Items.list client, %{page: 1, per_page: 40, query: "qiita"}
    ```
    
  """
  def list(client, params \\ []) do
    get "/items", client, params
  end

  @doc """
  Get an Item.

  ## Example
    
    ```
    Qiitex.Item.find client, "itemid"
    ```
    
  """
  def find(client, item_id) do
    get "/items/#{item_id}", client
  end

  @doc """
  List tagged items in recently-tagged order.


  ## Example
    
    ```
    Qiitex.Items.list_tag_items client, "tag_id"
    Qiitex.Items.list_tag_items client, "tag_id", %{page: 1, per_page: 40}
    ```
    
  """
  def list_tag_items(client, tag_id, params \\ []) do
    get "/tags/#{tag_id}/items", client, params
  end

  @doc """
  List a user's items in newest order.

  ## Example
    
    ```
    Qiitex.Items.list_user_items client, "user_id"
    Qiitex.Items.list_user_items client, "user_id", %{page: 1, per_page: 40}
    ```
    
  """
  def list_user_items(client, user_id, params \\ []) do
    get "/users/#{user_id}/items", client, params
  end

  @doc """
  List a user's stocked items in recently-stocked order.

  ## Example
    
    ```
    Qiitex.Items.list_user_stock_items client, "user_id"
    Qiitex.Items.list_user_stock_items client, "user_id", %{page: 1, per_page: 40}
    ```
    
  """
  def list_user_stock_items(client, user_id, params \\ []) do
    get "/users/#{user_id}/stocks", client, params
  end

  @doc """
  List the authenticated user's items in newest order

  ## Example
    
    ```
    Qiitex.Items.list_authenticated_user_items client
    Qiitex.Items.list_authenticated_user_items client, %{page: 2, per_page: 40}
    ```
    
  """
  def list_authenticated_user_items(client, params \\ []) do
    get "/authenticated_user/items", client, params
  end

  @doc """
  Create an item.

  ## Example
    
    ```
    Qiitex.Items.create client, %{title: "title", body: "body", tags: [%{name: "qiita"}]}
    ```
    
  """
  def create(client, params) do
    post "/items", client, params
  end

  @doc """
  Delete an item.

  ## Example
    
    ```
    Qiitex.Item.delete_item client, "itemid"
    ```
    
  """
  def delete_item(client, item_id) do
    delete "/items/#{item_id}", client
  end

  @doc """
  Update an item.

  ## Example
    
    ```
    Qiitex.Items.update client, "itemid", %{title: "title", body: "body", tags: [%{name: "qiita"}]}
    ```
    
  """
  def update(client, item_id, params) do
    patch "/items/#{item_id}", client, params
  end

  @doc """
  Stock an item.

  ## Example
    
    ```
    Qiitex.Items.stock client, "itemid"
    ```
    
  """
  def stock(client, item_id) do
    put "/items/#{item_id}/stock", client
  end

  @doc """
  Unstock an item.

  ## Example
    
    ```
    Qiitex.Items.unstock client, "itemid"
    ```
    
  """
  def unstock(client, item_id) do
    delete "/items/#{item_id}/stock", client
  end

  @doc """
  Check if you stocked an item.

  ## Example
    
    ```
    Qiitex.Items.get_stock client, "itemid"
    ```
    
  """
  def get_stock(client, item_id) do
    get "/items/#{item_id}/stock", client
  end

end
