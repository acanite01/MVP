defmodule App.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias App.Repo
  alias __MODULE__

  schema "items" do
    field :text, :string

    belongs_to :status, App.Status, on_replace: :nilify
    belongs_to :person, App.Person
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{text: "Learn LiveView"})
      {:ok, %Item{}}

      iex> create_item(%{text: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}, person, status) do
    %Item{}
    |> changeset(attrs)
    |> put_assoc(:person, person)
    |> put_assoc(:status, status)
    |> Repo.insert()
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Returns the list of items where the status is different to "deleted"

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Item
    |> order_by(desc: :inserted_at)
    # |> where([a], is_nil(a.status_code) or a.status_code != 6)
    |> Repo.all()
    |> Repo.preload([:status])
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def update_status(%Item{} = item, status) do
    item
    |> Repo.preload(:status)
    |> Ecto.Changeset.change()
    |> put_assoc(:status, status)
    |> Repo.update()
  end

  # "soft" delete
  def delete_item(id) do
    get_item!(id)
    |> Item.changeset(%{status_code: 6})
    |> Repo.update()
  end
end
