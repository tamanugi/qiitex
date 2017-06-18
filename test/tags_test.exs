defmodule Qiitex.TagsTest do
    use ExUnit.Case
    import Qiitex.Tags
    alias Qiitex.Schema.SchemaHelper

    @client Qiitex.Client.new

    setup_all do
        HTTPoison.start
    end

    test "tags/1" do

        tags(@client)
        |> Enum.each(fn(e) ->
          assert ExJsonSchema.Validator.validate(SchemaHelper.schema("tag") , e) == :ok
        end)
    end
end
