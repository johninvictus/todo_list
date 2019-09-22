defmodule TodoList.Todo do
  defstruct id: nil, title: nil, description: nil, done: false

  alias __MODULE__

  def new(entry \\ %{}) do
    cond do
      map_size(entry) >= 1 ->
        struct(%Todo{}, entry)

      true ->
        %{}
    end
  end

  def update_id(%Todo{} = todo, value) do
    %{todo | id: value}
  end
end
