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
      {href_args, param_args} = Qiitex.Documentation.get_required_arguments(doc)
      href = doc["href"]
      method = String.to_atom(doc["method"])

      arguments = List.flatten([href_args, param_args])
                    |> Enum.map(fn x ->
                      x
                      |> String.to_atom
                      |> Macro.var(module)
                    end)

      @doc """
      #{Qiitex.Documentation.create_doc_string(doc)}
      """
      unless Qiitex.Documentation.has_option_params?(doc) do
        def unquote(function_name)(client, unquote_splicing(arguments)) do
          {url, params} = create_url_and_params(unquote(href), unquote(arguments), unquote(param_args))
          perfom(unquote(method), client, url, params)
        end
      else
        def unquote(function_name)(client, unquote_splicing(arguments), option \\ %{}) do
          {url, params} = create_url_and_params(unquote(href), unquote(arguments), unquote(param_args))
          perfom(unquote(method), client, url, Map.merge(params, option))
        end
      end
    end)

    defp create_url_and_params(url, arguments, param_args) do
      {splited_url, rest_params} = url
      |> String.split("/")
      |> Enum.map_reduce(arguments, fn x, acc ->
        case x do
          ":" <> _ ->
            acc |> List.pop_at(0)
          _ -> {x, acc}
        end
      end)

      params = Enum.zip(param_args,rest_params) |> Enum.into(%{})

      {splited_url |> Enum.join("/"), params}
    end

    defp perfom(method, client, path, params) do
      Qiitex.request(method, client, path, params)
    end
  end
end)
