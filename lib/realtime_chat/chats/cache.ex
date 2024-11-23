defmodule RealtimeChat.Chats.Cache do
  @moduledoc """
  A dynamic supervisor for managing chat processes.

  This module is responsible for starting and supervising chat processes for users.
  It ensures that each user has a dedicated chat process and supervises these processes
  using a `:one_for_one` strategy.

  ## Functions

    * `start_link/1` - Starts the chat cache supervisor.
    * `init/1` - Initializes the supervisor with a `:one_for_one` strategy.
    * `chat_process/1` - Retrieves an existing chat process for a user or starts a new one.
    * `existing_chat/1` - Checks if a chat process already exists for a user.
    * `new_chat/1` - Starts a new chat process for a user if one does not already exist.

  ## Examples

      iex> RealtimeChat.Chats.Cache.start_link([])
      :ok

      iex> RealtimeChat.Chats.Cache.chat_process(1)
      #PID<0.123.0>

  """

  use DynamicSupervisor
  require Logger

  @doc """
  Starts the chat cache supervisor.

  Logs the start of the chat cache and starts the DynamicSupervisor.

  ## Examples

      iex> RealtimeChat.Chats.Cache.start_link([])
      :ok

  """
  def start_link([]) do
    Logger.info("Starting Chat Cache")
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  Initializes the supervisor with a `:one_for_one` strategy.

  ## Examples

      iex> RealtimeChat.Chats.Cache.init(nil)
      {:ok, %DynamicSupervisor{strategy: :one_for_one}}

  """
  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Retrieves an existing chat process for a user or starts a new one.

  ## Examples

      iex> RealtimeChat.Chats.Cache.chat_process(1)
      #PID<0.123.0>

  """
  def chat_process(user_id) do
    existing_chat(user_id) || new_chat(user_id)
  end

  defp existing_chat(user_id) do
    RealtimeChat.Chats.Server.whereis(user_id)
  end

  defp new_chat(user_id) do
    case DynamicSupervisor.start_child(__MODULE__, {RealtimeChat.Chats.Server, user_id}) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end
end
