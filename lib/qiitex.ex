defmodule Qiitex do
  alias Qiitex.Client

  @user_agent {"User-agent", "qiitex"}
  @content_type {"Content-Type", "application/json"}

  def request(method, client, path, params) do
    headers = authorization_header(client.auth)
    url = url(client, path)
    _request(method, url, params, headers)
  end

  defp _request(:GET, url, params, header) do
    HTTPoison.get!(url, header, params: params)
    |> process_response
  end
  defp _request(:POST, url, params, header) do
    HTTPoison.post!(url, body(params), header)
    |> process_response
  end
  defp _request(:DELETE, url, _params, header) do
    HTTPoison.delete!(url, header)
    |> process_response
  end
  defp _request(:PATCH, url, params, header) do
    HTTPoison.patch!(url, params, header)
    |> process_response
  end
  defp _request(:PUT, url, params, header) do
    HTTPoison.put!(url, params, header)
    |> process_response
  end

  defp body(params) when is_map(params) do
    params
    |> Poison.encode!
  end

  def process_response(%HTTPoison.Response{status_code: status_code, body: body}) when status_code in [400, 401, 403, 404, 500] do
    {_, res} = body
    |> Poison.decode

    {:error, res}
  end

  def process_response(%HTTPoison.Response{body: body}) do
    {_, res} = body
    |> Poison.decode

    {:ok, res}
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
  def authorization_header(options), do: authorization_header(options, [@user_agent, @content_type])
end
