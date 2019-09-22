defmodule TodoList.TodoServer do
  use GenServer

  alias TodoList.{Todos}

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def add_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:add_entry, entry})
  end

  def todos(todo_server) do
    GenServer.call(todo_server, :todos)
  end

  @impl GenServer
  def init(_) do
    {:ok, Todos.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, entry}, todos) do
    new_state = Todos.add_entry(todos, entry)
    {:noreply, new_state}
  end

  @impl GenServer
  def handle_call(:todos, _from, todos) do
    {:reply, todos, todos}
  end
end
