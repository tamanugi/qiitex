# Qiitex

[![hex.pm version](https://img.shields.io/hexpm/v/qiitex.svg)](https://hex.pm/packages/qiitex)

Simple Elixir wrapper for the [Qiita v2 API](https://qiita.com/api/v2/docs).

Based heavily on the [Tentacat](https://github.com/edgurgel/tentacat) libraries

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `qiitex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:qiitex, "~> 0.1.0"}]
end
```

## Usage

```elixir
iex> client = Qiitex.client.new %{access_token: "enteryouraccesstoken"}
iex> Qiitex.Tags.list client
iex> Qiitex.Items.create client, %{title: "title", body: "body", tags: [%{name: "qiita"}]}
```

## Features

### Scope
- [ ] GET /api/v2/oauth/authorize

### Access token
- [ ] POST /api/v2/access_tokens
- [ ] DELETE /api/v2/access_tokens/:access_token

### Authenticated user
- [x] GET /api/v2/authenticated_user

### Comment 
- [x] DELETE /api/v2/comments/:comment_id
- [x] GET /api/v2/comments/:comment_id
- [x] PATCH /api/v2/comments/:comment_id
- [ ] DELETE /api/v2/comments/:comment_id/thank
- [ ] PUT /api/v2/comments/:comment_id/thank
- [x] GET /api/v2/items/:item_id/comments
- [x] POST /api/v2/items/:item_id/comments
 
### Emoji reaction
 
- [x] POST /api/v2/comments/:comment_id/reactions
- [x] POST /api/v2/items/:item_id/reactions
- [ ] POST /api/v2/projects/:project_id/reactions
- [x] DELETE /api/v2/comments/:comment_id/reactions/:reaction_name
- [x] DELETE /api/v2/items/:item_id/reactions/:reaction_name
- [ ] DELETE /api/v2/projects/:project_id/reactions/:reaction_name
- [x] GET /api/v2/comments/:comment_id/reactions
- [x] GET /api/v2/items/:item_id/reactions
- [ ] GET /api/v2/projects/:project_id/reactions
 
### Expanded template
 
- [ ] POST /api/v2/expanded_templates
 
### Item
 
- [x] GET /api/v2/authenticated_user/items
- [x] GET /api/v2/items
- [x] POST /api/v2/items
- [ ] DELETE /api/v2/items/:item_id
- [x] GET /api/v2/items/:item_id
- [x] PATCH /api/v2/items/:item_id
- [ ] DELETE /api/v2/items/:item_id/like
- [ ] PUT /api/v2/items/:item_id/like
- [x] PUT /api/v2/items/:item_id/stock
- [x] DELETE /api/v2/items/:item_id/stock
- [x] GET /api/v2/items/:item_id/stock
- [ ] GET /api/v2/items/:item_id/like
- [x] PUT /api/v2/items/:item_id/stock
- [x] GET /api/v2/tags/:tag_id/items
- [x] GET /api/v2/users/:user_id/items
- [x] GET /api/v2/users/:user_id/stocks
 
### Like
 
- [ ] GET /api/v2/items/:item_id/likes
 
### Project
 
- [ ] GET /api/v2/projects
- [ ] POST /api/v2/projects
- [ ] DELETE /api/v2/projects/:project_id
- [ ] GET /api/v2/projects/:project_id
- [ ] PATCH /api/v2/projects/:project_id
 
### Tag
 
- [x] GET /api/v2/tags
- [x] GET /api/v2/tags/:tag_id
- [x] GET /api/v2/users/:user_id/following_tags
- [x] DELETE /api/v2/tags/:tag_id/following
- [x] GET /api/v2/tags/:tag_id/following
- [x] PUT /api/v2/tags/:tag_id/following
 
### Tagging
 
- [ ] POST /api/v2/items/:item_id/taggings
- [ ] DELETE /api/v2/items/:item_id/taggings/:tagging_id
 
### Team
 
- [ ] GET /api/v2/teams
 
### Template
 
- [ ] GET /api/v2/templates
- [ ] DELETE /api/v2/templates/:template_id
- [ ] GET /api/v2/templates/:template_id
- [ ] POST /api/v2/templates
- [ ] PATCH /api/v2/templates/:template_id
 
### User
 
- [x] GET /api/v2/items/:item_id/stockers
- [x] GET /api/v2/users
- [x] GET /api/v2/users/:user_id
- [x] GET /api/v2/users/:user_id/followees
- [x] GET /api/v2/users/:user_id/followers
- [x] DELETE /api/v2/users/:user_id/following
- [x] GET /api/v2/users/:user_id/following
- [x] PUT /api/v2/users/:user_id/following

-------------------------------------------
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/qiitex](https://hexdocs.pm/qiitex).

