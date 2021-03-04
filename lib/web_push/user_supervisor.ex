defmodule Bonfire.Notify.WebPush.UserSupervisor do
  @moduledoc """
  The supervisor for user processes.
  """

  use DynamicSupervisor

  alias Bonfire.Notify.WebPush.UserWorker

  # Client

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def start_worker(user_id) do
    spec = {UserWorker, user_id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  # Server

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
