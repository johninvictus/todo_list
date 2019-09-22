defmodule TodoList.Cache do
  use GenServer

  alias TodoList.{TodoServer, Database}

  @moduledoc """
   This module will be used to store todo list pid,
   hence different todos will have unique pids
  """
  def start do
    GenServer.start(__MODULE__, nil)
  end

  @doc """
   Fetch todo server, if not available create it first
  """
  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end

  @impl GenServer
  def init(_) do
    # start db and use it in server
    send self(), :start_db

    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        server = TodoServer.start_link(todo_list_name)
        {:reply, server, Map.put(todo_servers, todo_list_name, server)}
    end
  end

  @impl GenServer
  def handle_info(:start_db, state) do
    Database.start()
    {:noreply, state}
  end
end
