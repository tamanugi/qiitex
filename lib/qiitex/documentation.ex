defmodule Qiitex.Documentation do
  def get_required_arguments(doc, module) do
    href_args = get_href_args(doc)
    param_args = doc |> get_schema() |> get_required

    {href_args, param_args}
  end

  defp get_href_args(%{"href" => url}) do
     ~r/:([a-z_]*)/
    |> Regex.scan(url)
    |> Enum.map(fn [_, x] -> x end)
  end

  defp get_schema(%{"schema" => schema}) do
    schema
  end
  defp get_schema(_), do: %{}

  defp get_required(%{"required" => required}), do: required
  defp get_required(_), do: []

  def has_option_params?(%{"schema" => schema}), do: has_option_params?(schema)
  def has_option_params?(%{"properties" => properties, "required" => required}) do
    properties
    |> Map.to_list
    |> length != length(required)
  end
  def has_option_params?(%{"properties" => _}), do: true
  def has_option_params?(%{}), do: false

  defp get_option(true), do: ["option \\\\ %{}"]
  defp get_option(_), do: []

  defp get_properties(%{"properties" => properties}), do: properties
  defp get_properties(_), do: %{}

  defp optional_str(key, doc) do
    doc
    |> get_schema
    |> get_required
    |> Enum.member?(key)
    |> optional_str
  end
  defp optional_str(false), do: "`optional`"
  defp optional_str(_), do: ""

  def create_doc_string(doc) do
    title = "**#{doc["method"]} #{doc["href"]}**"
    description = doc["description"]

    schema = get_schema(doc)

    params = schema 
    |> get_properties
    |> Map.to_list
    |> Enum.map(fn {key, prop} ->
      other_desc = prop
      |> Map.to_list
      |> Enum.filter(fn {key, _} ->
        Enum.member?(["type", "example", "format", "pattern"], key)
      end)
      |> Enum.map(fn {pk, pv} = x ->
        case pv do
          str when is_binary(str) -> "  * #{pk}: `#{pv}`"
          n ->
            s = n |> Poison.encode!
            "  * #{pk}: `#{s}`"
        end
      end)
      |> Enum.join("\n")

      """
      * #{key} #{optional_str(key, doc)}
        * #{prop["description"]}
      #{other_desc}
      """
    end)
    |> Enum.join("\n")

    Enum.join([
      description,
      title,
      params
    ], "\n\n")
  end

end