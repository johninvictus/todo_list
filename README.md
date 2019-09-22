# TodoList

**TODO: Add description**


```ELIXIR
{:ok, cache} = TodoList.Cache.start
{:ok, server} = TodoList.Cache.server_process(cache, "bobs_list")

TodoList.TodoServer.add_entry(server, %{title: "hello", description: "magic"})

# results
TodoList.TodoServer.todos(server)

%TodoList.Todos{
  auto_id: 2,
  entries: %{
    1 => %TodoList.Todo{
      description: "magic",
      done: false,
      id: 1,
      title: "hello"
    }
  }
}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `todo_list` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:todo_list, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/todo_list](https://hexdocs.pm/todo_list).

