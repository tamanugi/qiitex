defmodule Qiitex.Tags do
    import Qiitex

    def tags(client) do
        get "/tags", client
    end
end
