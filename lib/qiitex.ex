defmodule Qiitex do
  use HTTPoison.Base

  alias Qiitex.Client

  @user_agent [{"User-agent", "qiitex"}]

  @type response :: binary | {integer, binary}

  @spec process_response_body(binary) :: Poison.Parser.t
  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
  def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }

  @spec delete(binary, Client.t, binary) :: response
  def delete(path, client, body \\ "") do
    _request(:delete, url(client, path), client.auth, body)
  end

  @spec post(binary, Client.t, binary) :: response
  def post(path, client, body \\ "") do
    _request(:post, url(client, path), client.auth, body)
  end

  @spec patch(binary, Client.t, binary) :: response
  def patch(path, client, body \\ "") do
    _request(:patch, url(client, path), client.auth, body)
  end

  @spec put(binary, Client.t, binary) :: response
  def put(path, client, body \\ "") do
    _request(:put, url(client, path), client.auth, body)
  end

  @spec get(binary, Client.t, [{atom, binary}] | []) :: response
  def get(path, client, params \\ []) do
    initial_url = url(client, path)
    url = add_params_to_url(initial_url, params)
    _request(:get, url, client.auth)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(
      method, url, body,
      ["Content-Type": "application/json"] ++ authorization_header(auth, @user_agent)
    )
    |> process_response
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    _body = case body do
      "" -> body
      _  -> Poison.encode!(body) 
    end
    request!(method, url, _body, headers, options) 
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  defp add_params_to_url(url, params) do
    <<url :: binary, build_qs(params) :: binary>>
  end

  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

  @doc """
  ## Examples
      iex> Qiitex.authorization_header(%{access_token: "92873971893"}, [])
      [{"Authorization", "Bearer 92873971893"}]
  """
  @spec authorization_header(Client.auth, list) :: list
  def authorization_header(%{access_token: token}, headers) do
    headers ++ [{"Authorization", "Bearer #{token}"}]
  end

  def authorization_header(_, headers), do: headers

  @doc """
  Same as `authorization_header/2` but defaults initial headers to include `@user_agent`.
  """
  def authorization_header(options), do: authorization_header(options, @user_agent)

end
