defmodule RealtimeChat.Chats do
  alias RealtimeChat.Chats.Cache
  alias RealtimeChat.Chats.Server

  def start_process(user_id) do
    Cache.chat_process(user_id)
  end

  def store_message_received(user_id, message) do
    pid = Cache.chat_process(user_id)
    Server.store_message_received(pid, message)
  end

  def store_message_send(user_id, message) do
    pid = Cache.chat_process(user_id)
    Server.store_message_send(pid, message)
  end

  def get_message_history(user_id, for_user) do
    pid = Cache.chat_process(user_id)

    Server.get_message_history(pid, String.to_integer(for_user))
    |> Enum.reverse()
  end
end
