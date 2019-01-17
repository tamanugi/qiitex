defmodule Qiitex.Api do

  def get_documentation() do
    File.read!("lib/qiitex/docs/schema.json")
    |> Poison.decode!()
    |> Map.get("properties")
    |> Map.to_list
    |> Enum.filter(fn {_, info} -> Map.has_key?(info, "links") end)
  end
end

Enum.each(Qiitex.Api.get_documentation(), fn {module_name, functions} ->
  module_name = module_name |> Macro.camelize()
  module = Module.concat(Qiitex.Api, module_name)

  defmodule module do
    @moduledoc """
    #{functions["description"]}
    """

    Enum.each(functions["links"] |> Enum.uniq, fn doc ->
      function_name = doc["title"] |> String.to_atom
      arguments = Qiitex.Documentation.get_required_arguments(doc, module)
      href = doc["href"]
      method = String.to_atom(doc["method"])

      @doc """
      #{Qiitex.Documentation.create_doc_string(doc)}
      """
      unless Qiitex.Documentation.has_option_params?(doc) do
        def unquote(function_name)(client, unquote_splicing(arguments)) do
          {url, params} = create_url_and_params(unquote(href), unquote(arguments))
          perfom(unquote(method), client, url, params, %{})
        end
      else
        def unquote(function_name)(client, unquote_splicing(arguments), option \\ %{}) do
          {url, params} = create_url_and_params(unquote(href), unquote(arguments))
          perfom(unquote(method), client, url, params, option)
        end
      end
    end)

    defp create_url_and_params(url, arguments) do
      {splited_url, rest_params} = url
      |> String.split("/")
      |> Enum.map_reduce(arguments, fn x, acc ->
        case x do
          ":" <> _ ->
            acc |> List.pop_at(0)
          _ -> {x, acc}
        end
      end)

      {splited_url |> Enum.join("/"), rest_params}
    end

    defp perfom(:GET, client, url, params, _options) do
      IO.inspect url
      Qiitex.get(url, client, params)
    end
    defp perfom(:POST, client, url, params, _options) do
      Qiitex.get(url, client, params)
    end
    defp perfom(:DELTE, client, url, params, _options) do
      Qiitex.get(url, client, params)
    end
    defp perfom(:PATCH, client, url, params, _options) do
      Qiitex.get(url, client, params)
    end
    defp perfom(:PUPT, client, url, params, _options) do
      Qiitex.get(url, client, params)
    end
    defp perfom(:UPDATE, client, url, params, _options) do
      Qiitex.get(url, client, params)
    end

  end
end)
  