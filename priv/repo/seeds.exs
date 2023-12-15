# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StoicQuotes.Repo.insert!(%StoicQuotes.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias StoicQuotes.Quotes
quotes_path = "priv/repo/quotes.json"

quotes_path
|> File.read!()
|> Jason.decode!()
|> Enum.each(fn attrs ->
  quote = %{quote: attrs["quote"], author: attrs["author"], source: attrs["source"]}

  case Quotes.create_quote(quote) do
    {:ok, _quote} ->
      :ok

    {:error, _changeset} ->
      :duplicate
  end
end)
