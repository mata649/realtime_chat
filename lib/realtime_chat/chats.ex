defmodule RealtimeChat.Chats do
  @moduledoc """
  A module for managing chat interactions.

  This module provides functions to start chat processes, store messages, and retrieve message history for users.

  ## Functions

    * `start_process/1` - Starts a chat process for a user.
    * `store_message_received/2` - Stores a received message for a user.
    * `store_message_send/2` - Stores a sent message for a user.
    * `get_message_history/2` - Retrieves the message history for a user.

  ## Examples

      iex> RealtimeChat.Chats.start_process(1)
      #PID<0.123.0>

      iex> RealtimeChat.Chats.store_message_received(1, "Hello")
      :ok

      iex> RealtimeChat.Chats.store_message_send(1, "Hi")
      :ok

      iex> RealtimeChat.Chats.get_message_history(1, "2")
      ["Hi", "Hello"]

  """

  alias RealtimeChat.Chats.Cache
  alias RealtimeChat.Chats.Server

  @doc """
  Starts a chat process for a user.

  ## Examples

      iex> RealtimeChat.Chats.start_process(1)
      #PID<0.123.0>

  """
  def start_process(user_id) do
    Cache.chat_process(user_id)
  end

  @doc """
  Stores a received message for a user.

  ## Examples

      iex> RealtimeChat.Chats.store_message_received(1, "Hello")
      :ok

  """
  def store_message_received(user_id, message) do
    pid = Cache.chat_process(user_id)
    Server.store_message_received(pid, message)
  end

  @doc """
  Stores a sent message for a user.

  ## Examples

      iex> RealtimeChat.Chats.store_message_send(1, "Hi")
      :ok

  """
  def store_message_send(user_id, message) do
    pid = Cache.chat_process(user_id)
    Server.store_message_send(pid, message)
  end

  @doc """
  Retrieves the message history for a user.

  ## Examples

      iex> RealtimeChat.Chats.get_message_history(1, "2")
      ["Hi", "Hello"]

  """
  def get_message_history(user_id, for_user) do
    pid = Cache.chat_process(user_id)

    Server.get_message_history(pid, String.to_integer(for_user))
    |> Enum.reverse()
  end
end
