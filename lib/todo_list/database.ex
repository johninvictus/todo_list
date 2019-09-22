defmodule TodoList.Database do
  use GenServer

  @name __MODULE__

  def start(db_folder) do
    GenServer.start(__MODULE__, db_folder, name: @name)
  end

  def store({key, data}) do
    GenServer.call(@name, {:store, key, data})
  end

  def get(key) do
    GenServer.call(@name, {:get, key})
  end

  @impl GenServer
  def init(db_folder) do
    # create folder
    send(self(), {:create_folder, db_folder})

    {:ok, db_folder}
  end

  @impl GenServer
  def handle_info({:create_folder, db_folder}, db_folder) do
    File.mkdir_p(db_folder)
    {:noreply, db_folder}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, db_folder) do
    file_name(db_folder, key)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, db_folder}
  end

  @impl GenServer
  def handle_call({:get, key}, _from, db_folder) do
    data =
      case File.read(file_name(db_folder, key)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, db_folder}
  end

  defp file_name(db_folder, key), do: "#{db_folder}/#{key}"
end
