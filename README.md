# RealtimeChat

**RealtimeChat** is a simple, real-time chat app built with [Phoenix](https://www.phoenixframework.org/). It uses Phoenix's Pub/Sub for instant messaging and in-memory processes for chat management.  

## Features  

- **Real-Time Messaging**: Messages are broadcast instantly using Phoenix Pub/Sub.  
- **In-Memory Chat Storage**: Chats are handled in memory with `GenServer` processes.  
- **Dynamic Supervision**: Chat processes are created and managed dynamically with `DynamicSupervisor`.  
- **Global Registry**: Keeps track of all active chat rooms.  

![Example Image](priv/static/images/example.png)

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
