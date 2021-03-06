defmodule Bonfire.Notify.Test.FakeHelpers do

  alias Bonfire.Data.Identity.Account
  alias Bonfire.Me.Fake
  alias Bonfire.Me.{Accounts, Users}

  import ExUnit.Assertions

  import Bonfire.Common.Config, only: [repo: 0]

  def fake_account!(attrs \\ %{}) do
    cs = Accounts.signup_changeset(Fake.account(attrs))
    assert {:ok, account} = repo().insert(cs)
    account
  end

  def fake_user!(account \\ %{}, attrs \\ %{})

  def fake_user!(%Account{}=account, attrs) do
    assert {:ok, user} = Users.create(Fake.user(attrs), account)
    user
  end

  def fake_user!(account_attrs, user_attrs) do
    fake_user!(fake_account!(account_attrs), user_attrs)
  end

  def valid_push_subscription_data(endpoint \\ "https://endpoint.test") do
    """
      {
        "endpoint": "#{endpoint}",
        "expirationTime": null,
        "keys": {
          "p256dh": "p256dh",
          "auth": "auth"
        }
      }
    """
  end

end
