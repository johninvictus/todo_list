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
  def handle_cast({:add_entry, entry}, {name, todos}) do
    new_state = Todos.add_entry(todos, entry)
    Database.store(name, new_state)
    {:noreply, new_state}
  end

  @impl GenServer
  def handle_call(:todos, _from, todos) do
    {:reply, todos, todos}
  end
end
