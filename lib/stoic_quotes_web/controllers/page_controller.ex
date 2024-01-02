defmodule StoicQuotesWeb.PageController do
  use StoicQuotesWeb, :controller
  alias StoicQuotes.Quotes

  def home(conn, _params) do
    quote_data = Quotes.get_random_quote!()

    conn
    |> assign(:layout, false)
    |> assign(:quote, quote_data.quote)
    |> assign(:author, quote_data.author)
    |> assign(:source, quote_data.source)
    |> render(:home)
  end
end
