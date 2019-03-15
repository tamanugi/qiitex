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
      href_args = Qiitex.Documentation.get_href_args(doc)
      href = doc["href"]
      method = String.to_atom(doc["method"])

      arguments = href_args
                    |> Enum.map(fn x ->
                      x
                      |> String.to_atom
                      |> Macro.var(module)
                    end)

      @doc """
      #{Qiitex.Documentation.create_doc_string(doc)}
      """
      cond do
        Qiitex.Documentation.has_required?(doc) ->
          def unquote(function_name)(client, unquote_splicing(arguments), params) do
            path = build_path_with_arguments(unquote(href), unquote(arguments))
            perfom(unquote(method), client, path, params)
          end
        Qiitex.Documentation.has_option?(doc) ->
          def unquote(function_name)(client, unquote_splicing(arguments), options \\ %{}) do
            path = build_path_with_arguments(unquote(href), unquote(arguments))
            perfom(unquote(method), client, path, options)
          end
        true ->
          def unquote(function_name)(client, unquote_splicing(arguments)) do
            path = build_path_with_arguments(unquote(href), unquote(arguments))
            perfom(unquote(method), client, path, %{})
          end
      end
    end)

    defp build_path_with_arguments(url, arguments) do
      {splited_url, _} = url
      |> String.split("/")
      |> Enum.map_reduce(arguments, fn x, acc ->
        case x do
          ":" <> _ ->
            acc |> List.pop_at(0)
          _ -> {x, acc}
        end
      end)

      splited_url |> Enum.join("/")
    end

    defp perfom(method, client, path, params) do
      Qiitex.request(method, client, path, params)
    end
  end
end)
