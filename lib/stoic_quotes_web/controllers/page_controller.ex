defmodule StoicQuotesWeb.PageController do
  use StoicQuotesWeb, :controller
  alias StoicQuotes.Quotes

  def home(conn, _params) do
    quote_data =
      case Quotes.get_random_quote() do
        nil ->
          %{quote: "No quotes available", author: "N/A", source: "N/A"}

        quote ->
          quote
      end

    conn
    |> assign(:layout, false)
    |> assign(:quote, quote_data.quote)
    |> assign(:author, quote_data.author)
    |> assign(:source, quote_data.source)
    |> render(:home)
  end
end
