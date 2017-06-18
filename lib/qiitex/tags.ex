defmodule Qiitex.Tags do
    import Qiitex

    def list(client) do
        get "/tags", client
    end

    def find(client, tag_id \\ "") do
        get "/tags/#{tag_id}", client
    end
end
