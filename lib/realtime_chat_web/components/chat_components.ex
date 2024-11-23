defmodule RealtimeChatWeb.ChatComponents do
  use Phoenix.Component

  def my_message(assigns) do
    ~H"""
    <div class="flex justify-end w-full mt-2">
      <div class="flex flex-col w-1/3 gap-2 pt-2 pb-4 pl-1 pr-2 rounded-xl bg-gruvbox-green mr-14">
        <div class="flex justify-enstart">
          <%= @text %>
        </div>
        <div class="flex justify-end w-full text-sm text-gruvboxDark-fg2">
          <%= Timex.format!(@send_at, "{YYYY}-{0M}-{0D}") %>
        </div>
      </div>
    </div>
    """
  end

  def others_message(assigns) do
    ~H"""
    <div class="flex justify-start w-full mt-2">
      <div class="flex flex-col w-1/3 gap-2 pt-2 pb-4 pl-2 pr-1 rounded-xl bg-gruvbox-blue ml-14">
        <div>
          <%= @text %>
        </div>
        <div class="flex justify-end w-full text-sm text-gruvboxDark-fg2">
          <%= Timex.format!(@send_at, "{YYYY}-{0M}-{0D}") %>
        </div>
      </div>
    </div>
    """
  end
end
