defmodule Qiitex do
  use HTTPoison.Base

  alias Qiitex.Client

  @user_agent [{"User-agent", "qiitex"}]

  @type response :: binary | {integer, binary}

  @spec process_response_body(binary) :: Poison.Parser.t
  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: _, body: body}), do: body
  def process_response(body), do: body

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
  def get(path, client, params \\ [], options \\ []) do
    url = url(client, path) |> add_params_to_url(params)

    # case pagination(options) do
    #   nil -> _request(:get, url, client.auth)
      # :stream -> request_stream(:get, url, client.auth)
    # end
    request_stream(:get, url, client.auth)
  end

  def request_stream(method, url, auth, body \\ "", override \\ "") do
    request_with_pagination(method, url, auth, body)
    |> stream_if_needed(override)
  end

  defp stream_if_needed(result = {status_code, _}, _) when is_number(status_code), do: result
  defp stream_if_needed({body, nil, _}, _), do: body
  defp stream_if_needed({body, _, _}, :one_page), do: body
  defp stream_if_needed(initial_results, _) do
    Stream.resource(
      fn -> initial_results end,
      &process_stream/1,
      fn _ -> nil end)
  end

  defp process_stream({[], nil, _}), do: {:halt, nil}
  defp process_stream({[], next, auth}) do
    IO.puts inspect next
    request_with_pagination(:get, next, auth, "")
    |> process_stream
  end
  defp process_stream({items, next, auth}) when is_list(items) do
    {items, {[], next, auth}}
  end
  defp process_stream({item, next, auth}) do
    {[item], {[], next, auth}}
  end

  def request_with_pagination(method, url, auth, body \\ "") do
    resp = json_request(
      method, url, body,
      ["Content-Type": "application/json"] ++ authorization_header(auth, @user_agent)
    )
    case process_response(resp) do
      x when is_tuple(x) -> x
      _ -> pagination_tuple(resp, auth)
    end
  end
  
  defp pagination_tuple(%HTTPoison.Response{headers: headers} = resp, auth) do
    {process_response(resp), next_link(headers), auth}
  end

  defp next_link(headers) do
    IO.puts inspect headers
    for {"Link", link_header} <- headers, links <- String.split(link_header, ",") do
      Regex.named_captures(~r/<(?<link>.*)>;\s*rel=\"(?<rel>.*)\"/, links)
      |> case do
        %{"link" => link, "rel" => "next"} -> link
        _ -> nil
      end
    end
    |> Enum.filter(&(not is_nil(&1)))
    |> List.first
  end

  defp pagination(options) do
    Keyword.get(options, :pagination, nil)
  end

  defp pagination_tuple(%HTTPoison.Response{headers: headers} = resp, auth) do
    {process_response(resp), next_link(headers), auth}
  end

  def _request(method, url, auth, body \\ "") do
    json_request(
      method, url, body,
      ["Content-Type": "application/json"] ++ authorization_header(auth, @user_agent)
    )
    |> process_response
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    encoded_body = case body do
      "" -> body
      _  -> Poison.encode!(body) 
    end
    request!(method, url, encoded_body, headers, options) 
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @doc """
  Take an existing URI and add addition params, appending and replacing as necessary
  ## Examples
      iex> add_params_to_url("http://example.com/wat", [])
      "http://example.com/wat"
      iex> add_params_to_url("http://example.com/wat", [q: 1])
      "http://example.com/wat?q=1"
      iex> add_params_to_url("http://example.com/wat", [q: 1, t: 2])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat", %{q: 1, t: 2})
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat", %{q: "1 2", t: "1:2"})
      "http://example.com/wat?q=1+2&t=1%3A2"
  """
  def add_params_to_url(url, params) do
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
