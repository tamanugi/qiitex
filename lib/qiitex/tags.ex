defmodule Qiitex.Tags do
    import Qiitex

    def list(client, params \\ []) do
        get "/tags", client, params
    end

    def find(client, tag_id \\ "") do
        get "/tags/#{tag_id}", client
    end
end
