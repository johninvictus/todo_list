defmodule TodoList.Todos do
  alias TodoList.{Todos, Todo}
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    entries |> Enum.reduce(%Todos{}, &add_entry(&2, &1))
  end

  def add_entry(%Todos{} = todos, %{} = todo) do
    updated_todo =
      todo
      |> Todo.new()
      |> Todo.update_id(todos.auto_id)

    new_entries = Map.put(todos.entries, todos.auto_id, updated_todo)

    %Todos{todos | entries: new_entries, auto_id: todos.auto_id + 1}
  end
end
