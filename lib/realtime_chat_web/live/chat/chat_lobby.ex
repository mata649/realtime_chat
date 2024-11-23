defmodule RealtimeChatWeb.ChatLobby do
  alias RealtimeChat.Chats.Message
  alias RealtimeChat.Chats
  alias RealtimeChat.Accounts
  alias RealtimeChatWeb.ChatComponents
  use RealtimeChatWeb, :live_view

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    IO.puts("ON MOUNTTTTTTTTTTTTTTTTTTTTTTTTTTTT")

    users = Accounts.get_users_except_for(current_user.id)
    RealtimeChatWeb.Endpoint.subscribe("user:#{current_user.id}")
    Chats.start_process(current_user.id)

    socket =
      socket
      |> stream(:users, users)
      |> stream(:messages, [])
      |> assign(:selected_chat, nil)
      |> assign(:message_form, %{})

    {:ok, socket}
  end

  def handle_event("select_chat", %{"selected_id" => selected_id}, socket) do
    current_user = socket.assigns.current_user
    messages = Chats.get_message_history(current_user.id, selected_id)

    socket =
      socket
      |> stream(:messages, messages, reset: true)
      |> assign(:selected_chat, selected_id)

    {:noreply, socket}
  end

  def handle_event("send_message", %{"text" => ""}, socket), do: {:noreply, socket}

  def handle_event("send_message", %{"text" => text, "to" => to}, socket) do
    current_user = socket.assigns.current_user

    message = %Message{
      id: UUID.uuid4(),
      from: current_user.id,
      to: String.to_integer(to),
      text: text,
      send_at: DateTime.utc_now()
    }

    Chats.store_message_send(current_user.id, message)
    RealtimeChatWeb.Endpoint.broadcast!("user:#{to}", "new_message", message)
    socket = socket |> stream_insert(:messages, message)
    {:noreply, socket}
  end

  def handle_info(%{event: "new_message", payload: message}, socket) do
    current_user = socket.assigns.current_user
    Chats.store_message_received(current_user.id, message)
    IO.inspect(message)
    socket = socket |> stream_insert(:messages, message)
    {:noreply, socket}
  end
end
