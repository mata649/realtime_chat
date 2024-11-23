defmodule RealtimeChat.Chats.Server do
  use GenServer, restart: :temporary
  require Logger

  def start_link(user_id) do
    Logger.info("Starting Chat for user[#{user_id}")
    GenServer.start_link(__MODULE__, user_id, name: global_name(user_id))
  end

  def store_message_send(pid, message) do
    GenServer.cast(pid, {:store_message_send, message})
  end

  def store_message_received(pid, message) do
    GenServer.cast(pid, {:store_message_received, message})
  end

  def get_message_history(pid, user_id) do
    GenServer.call(pid, {:get_message_history, user_id})
  end

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  defp global_name(user_id) do
    {:global, {__MODULE__, user_id}}
  end

  def whereis(user_id) do
    case :global.whereis_name({__MODULE__, user_id}) do
      :undefined -> nil
      pid -> pid
    end
  end

  @impl true
  def handle_cast({:store_message_send, %{to: to} = message}, history) do
    IO.inspect(message.to)
    messages = history |> Map.get(to, [])
    new_history = history |> Map.put(to, [message | messages])
    {:noreply, new_history}
  end

  @impl true
  def handle_cast({:store_message_received, %{from: from} = message}, history) do
    messages = history |> Map.get(from, [])
    new_history = history |> Map.put(from, [message | messages])

    {:noreply, new_history}
  end

  @impl true
  def handle_call({:get_message_history, user_id}, _from, history) do
    messages = history |> Map.get(user_id, [])
    {:reply, messages, history}
  end
end
