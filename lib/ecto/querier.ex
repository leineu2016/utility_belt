defmodule UtilityBelt.Ecto.Querier do
  @moduledoc """
  Helper functions for queries
  """
  require Logger
  alias Ecto.Adapters.SQL
  alias UtilityBelt.Ecto.Paginator
  alias UtilityBelt.Ecto.QueryBuilder, as: Builder

  def get(context) do
    args = context.args

    context.query
    |> Builder.with_select(get_fields(context))
    |> Builder.with_simple_where(args)
    |> context.repo.all()
  end

  def get_list(context) do
    {size, cursor} = Paginator.get_cursor(context)

    data =
      context.query
      |> Builder.with_select(get_fields(context))
      |> Builder.with_limit(cursor, size)
      |> context.repo.all()

    case context.aggr_fn do
      nil -> data
      fun -> fun.(data)
    end
  end

  def print_sql(query, repo) do
    {query, args} = SQL.to_sql(:all, repo, query)
    IO.puts("Query: #{query}. Params: #{inspect(args)}")
    query
  end

  # private functions
  defp get_fields(context) do
    result = context.fields ++ context.extra_fields
    Enum.uniq(result)
  end
end
