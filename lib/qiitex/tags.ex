defmodule Qiitex.Tags do
    import Qiitex

    def list(client) do
        get "/tags", client
    end
end
