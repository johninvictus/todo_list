defmodule TodoList.TodoServer do
  use GenServer

  alias TodoList.{Todos, Database}

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def add_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:add_entry, entry})
  end

  def todos(todo_server) do
    GenServer.call(todo_server, :todos)
  end

  @impl GenServer
  def init(name) do
    {:ok, {name, Database.get(name) || Todos.new()}}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, {name, todo_list}) do
    new_list = Todos.add_entry(todo_list, entry)
    Database.store(name, new_list)

    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_call(:todos, _from, {name, todos}) do
    {:reply, todos, {name, todos}}
  end
end
