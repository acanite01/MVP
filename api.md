<div align="center">

# `REST`ful API integration

</div>

This guide demonstrates
how to *extend* our MVP `Phoenix` application
so it also acts as an **API** 
returning `JSON` data.

We want our users to securely query
and manipulate their data 
and want to ensure all actions 
that are performed in the Web API
can also be done through our `RESTful` API
*and* `WebSocket API`
(for all real-time updates).

Let's get cracking! 🎉

## 1. Add `/api` scope and pipeline

We want all our API requests
to be made under the `/api` route.
This is easier for us to manage changes to API
that don't create unnecessary regressions to our liveviews.

Let's start by opening `lib/router.ex` 
and create a new `:api` pipeline
to be used under `scope "/api"`.

```elixir

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :authOptional do
    plug(AuthPlugOptional)
  end

  scope "/api", AppWeb do
    pipe_through [:api, :authOptional]

    resources "/items", API.ItemController, only: [:create, :update, :show]
    resources "/items/:item_id/timers", API.TimerController, only: [:create, :update, :show, :index]
  end
```

We are creating an `:api` pipeline 
that will only accepts and returns `json` objects.
`:fetch_session` is added as a plug 
because `:authOptional` requires us to do so.

Every request that is routed to `/api`
will be piped through both `:api` and `:authOptional` pipelines.

You might have noticed two new controllers:
`API.ItemController` and `API.TimerController`.
We are going to need to create these to handle our requests!

## 2. `ItemController` and `TimerController`

Before creating our controller, let's define our requirements. We want the API to:

- read contents of an `item`/`timer`
- list `timers` of an `item`
- create an `item` and return only the created `id`.
- edit an `item`

We want each endpoint to respond appropriately if any data is invalid, 
the response body and status should inform the user what went wrong. 
We can leverage changesets to validate the `item` and `timer`
and check if it's correctly formatted.

### 2.1 Adding tests

Let's approach this
with a [`TDD mindset`](https://github.com/dwyl/learn-tdd)
and create our tests first!

Create two new files:
- `test/app_web/api/item_controller_test.exs`
- `test/app_web/api/timer_controller_test.exs`

Before implementing,
we recommend giving a look at [`learn-api-design`](https://github.com/dwyl/learn-api-design),
we are going to be using some tips coming from there!

We want the API requests to be handled gracefully 
when an error occurs.
The person using the API 
[**should be shown meaningful errors**](https://github.com/dwyl/learn-api-design/blob/revamp/README.md#show-meaningful-errors).
Therefore, we need to test how our API behaves
when invalid attributes are requested
and/or an error occurs **and where**.

Let's start with `item_controller_test.exs`.

```elixir
defmodule AppWeb.API.ItemControllerTest do
  use AppWeb.ConnCase
  alias App.Item

  @create_attrs %{person_id: 42, status: 0, text: "some text"}
  @update_attrs %{person_id: 43, status: 0, text: "some updated text"}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}

  describe "show" do
    test "specific item", %{conn: conn} do
      {:ok, item} = Item.create_item(@create_attrs)
      conn = get(conn, Routes.item_path(conn, :show, item.id))

      assert conn.status == 200
      assert json_response(conn, 200)["id"] == item.id
      assert json_response(conn, 200)["text"] == item.text
    end

    test "not found item", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :show, -1))

      assert conn.status == 404
    end

    test "invalid id (not being an integer)", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :show, "invalid"))
      assert conn.status == 400
    end
  end

  describe "create" do
    test "a valid item", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create, @create_attrs))

      assert conn.status == 200
      assert json_response(conn, 200)["text"] == Map.get(@create_attrs, "text")

      assert json_response(conn, 200)["status"] == Map.get(@create_attrs, "status")

      assert json_response(conn, 200)["person_id"] == Map.get(@create_attrs, "person_id")
    end

    test "an invalid item", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create, @invalid_attrs))

      assert conn.status == 400
      assert length(json_response(conn, 400)["errors"]["text"]) > 0
    end
  end

  describe "update" do
    test "item with valid attributes", %{conn: conn} do
      {:ok, item} = Item.create_item(@create_attrs)
      conn = put(conn, Routes.item_path(conn, :update, item.id, @update_attrs))

      assert conn.status == 200
      assert json_response(conn, 200)["text"] == Map.get(@update_attrs, :text)
    end

    test "item with invalid attributes", %{conn: conn} do
      {:ok, item} = Item.create_item(@create_attrs)
      conn = put(conn, Routes.item_path(conn, :update, item.id, @invalid_attrs))

      assert conn.status == 400
      assert length(json_response(conn, 400)["errors"]["text"]) > 0
    end
  end
end
```

In `/item`, users will be able to
**create**, **update** or **query a single item**.
In each test we are testing 
successful scenarios (the [Happy Path](https://en.wikipedia.org/wiki/Happy_path)),
alongside situations where the person
requests non-existent items
or tries to create new ones with invalid attributes.

The same scenario occurs in `test/app_web/api/timer_controller_test.exs`.

```elixir
defmodule AppWeb.API.TimerControllerTest do
  use AppWeb.ConnCase
  alias App.Timer
  alias App.Item

  @create_item_attrs %{person_id: 42, status: 0, text: "some text"}

  @create_attrs %{item_id: 42, start: "2022-10-27T00:00:00"}
  @update_attrs %{item_id: 43, start: "2022-10-28T00:00:00"}
  @invalid_attrs %{item_id: nil, start: nil}

  describe "index" do
    test "timers", %{conn: conn} do
      # Create item and timer
      {item, timer} = item_and_timer_fixture()

      conn = get(conn, Routes.timer_path(conn, :index, item.id))

      assert conn.status == 200
      assert length(json_response(conn, 200)) == 1
    end
  end

  describe "show" do
    test "specific timer", %{conn: conn} do
      # Create item and timer
      {item, timer} = item_and_timer_fixture()

      conn = get(conn, Routes.timer_path(conn, :show, item.id, timer.id))

      assert conn.status == 200
      assert json_response(conn, 200)["id"] == timer.id
    end

    test "not found timer", %{conn: conn} do
      # Create item
      {:ok, item} = Item.create_item(@create_item_attrs)

      conn = get(conn, Routes.timer_path(conn, :show, item.id, -1))

      assert conn.status == 404
    end

    test "invalid id (not being an integer)", %{conn: conn} do
      # Create item
      {:ok, item} = Item.create_item(@create_item_attrs)

      conn = get(conn, Routes.timer_path(conn, :show, item.id, "invalid"))
      assert conn.status == 400
    end
  end

  describe "create" do
    test "a valid timer", %{conn: conn} do

      # Create item
      {:ok, item} = Item.create_item(@create_item_attrs)

      # Create timer
      conn = post(conn, Routes.timer_path(conn, :create, item.id, @create_attrs))

      assert conn.status == 200
      assert json_response(conn, 200)["start"] == Map.get(@create_attrs, "start")
    end

    test "an invalid timer", %{conn: conn} do
      # Create item
      {:ok, item} = Item.create_item(@create_item_attrs)

      conn = post(conn, Routes.timer_path(conn, :create, item.id, @invalid_attrs))

      assert conn.status == 400
      assert length(json_response(conn, 400)["errors"]["start"]) > 0
    end
  end

  describe "update" do
    test "timer with valid attributes", %{conn: conn} do
      # Create item and timer
      {item, timer} = item_and_timer_fixture()

      conn = put(conn, Routes.timer_path(conn, :update, item.id, timer.id, @update_attrs))

      assert conn.status == 200
      assert json_response(conn, 200)["start"] == Map.get(@update_attrs, :start)
    end

    test "timer with invalid attributes", %{conn: conn} do
      # Create item and timer
      {item, timer} = item_and_timer_fixture()

      conn = put(conn, Routes.timer_path(conn, :update, item.id, timer.id, @invalid_attrs))

      assert conn.status == 400
      assert length(json_response(conn, 400)["errors"]["start"]) > 0
    end
  end

  defp item_and_timer_fixture() do
    # Create item
    {:ok, item} = Item.create_item(@create_item_attrs)

    # Create timer
    started = NaiveDateTime.utc_now()
    {:ok, timer} = Timer.start(%{item_id: item.id, start: started})

    {item, timer}
  end
end
```

If you run `mix test`, they will fail,
because these functions aren't defined.

### 2.2 Implementing the controllers

It's time to implement our sweet controllers!
Let's start with `ItemController`.

Create a directory inside `lib/app_web/controllers/api`
and a file inside called `item_controller.ex`.
Paste the following code.

```elixir
defmodule AppWeb.API.ItemController do
  use AppWeb, :controller
  alias App.Item
  import Ecto.Changeset

  def show(conn, %{"id" => id} = _params) do
    case Integer.parse(id) do
      # ID is an integer
      {id, _float} ->
        case Item.get_item(id) do
          nil ->
            errors = %{
              code: 404,
              message: "No item found with the given \'id\'."
            }
            json(conn |> put_status(404), errors)

          timer ->
            json(conn, timer)
        end

      # ID is not an integer
      :error ->
        errors = %{
          code: 400,
          message: "The \'id\' is not an integer."
        }

        json(conn |> put_status(400), errors)
    end
  end

  def create(conn, params) do
    # Attributes to create item
    # Person_id will be changed when auth is added
    attrs = %{
      text: Map.get(params, "text"),
      person_id: 0,
      status: 2
    }

    case Item.create_item(attrs) do

      # Successfully creates item
      {:ok, item} ->
        id_item = Map.take(item, [:id])
        json(conn, id_item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_changeset_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update(conn, params) do
    id = Map.get(params, "id")
    new_text = Map.get(params, "text")

    item = Item.get_item!(id)

    case Item.update_item(item, %{text: new_text}) do

      # Successfully updates item
      {:ok, item} ->
        json(conn, item)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_changeset_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  defp make_changeset_errors_readable(changeset) do
    errors = %{
      code: 400,
      message: "Malformed request",
    }

    changeset_errors = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    Map.put(errors, :errors, changeset_errors)
  end
end
```

Each function should be self-explanatory.

- `:show` pertains to `GET api/items/:id` 
and returns an `item` object.
- `:create` refers to `POST api/items/:id` 
and yields the `id` of the newly created `item` object.
- `:update` refers to `PUT or PATCH api/items/:id` 
and returns the updated `item` object.

In cases where, for example,
`:id` is invalid when creating an `item`;
or there are missing fields when creating an `item`,
an error message is displayed in which fields
the changeset validation yielded errors.
To display errors meaningfully, 
we *traverse the errors* in the changeset
inside the `make_changeset_errors_readable/1` function.

For example, 
if you try to make a `POST` request
to `api/items` with the following body:

```json
{
    "invalid": "31231"
}
```

The API wil return a `400 Bad Request` HTTP status code
with the following message,
since it was expecting a `text` field:

```json
{
    "code": 400,
    "errors": {
        "text": [
            "can't be blank"
        ]
    },
    "message": "Malformed request"
}
```

To retrieve/update/create an `item`,
we are simply calling the schema functions
defined in `lib/app/timer.ex`.

Let's head over and create our `TimerController`!
Inside the same directory, create `timer_controller.ex`
and use this code.

```elixir
defmodule AppWeb.API.TimerController do
  use AppWeb, :controller
  alias App.Timer
  import Ecto.Changeset

  def index(conn, params) do
    item_id = Map.get(params, "item_id")

    timers = Timer.list_timers(item_id)
    json(conn, timers)
  end

  def show(conn, %{"id" => id} = _params) do
    case Integer.parse(id) do
      # ID is an integer
      {id, _float} ->
        case Timer.get_timer(id) do
          nil ->
            errors = %{
              code: 404,
              message: "No timer found with the given \'id\'."
            }
            json(conn |> put_status(404), errors)

          timer ->
            json(conn, timer)
        end

      # ID is not an integer
      :error ->
        errors = %{
          code: 400,
          message: "The \'id\' is not an integer."
        }

        json(conn |> put_status(400), errors)
    end
  end

  def create(conn, params) do
    # Attributes to create timer
    attrs = %{
      item_id: Map.get(params, "item_id"),
      start: Map.get(params, "start"),
      stop: Map.get(params, "stop")
    }

    case Timer.start(attrs) do

      # Successfully creates item
      {:ok, timer} ->
        id_timer = Map.take(timer, [:id])
        json(conn, id_timer)

      # Error creating item
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_changeset_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end

  def update(conn, params) do
    # Attributes to update timer
    attrs_to_update = %{
      id: Map.get(params, "id"),
      start: Map.get(params, "start"),
      stop: Map.get(params, "stop")
    }

    case Timer.update_timer(attrs_to_update) do

      # Successfully updates timer
      {:ok, timer} ->
        json(conn, timer)

      # Error creating timer
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = make_changeset_errors_readable(changeset)

        json(
          conn |> put_status(400),
          errors
        )
    end
  end


  defp make_changeset_errors_readable(changeset) do
    errors = %{
      code: 400,
      message: "Malformed request",
    }

    changeset_errors = traverse_errors(changeset, fn {msg, _opts} -> msg end)
    Map.put(errors, :errors, changeset_errors)
  end
end
```

The same set of conditions and operations
occur in `timer_controller.ex`.
The only difference is that there's an extra operation:
the person can list the `timers` for a specific `item`.
For this, we are using a function
that *is not yet implemented*
in `lib/app/timer.ex` - **`list_timers/1`**.


## 3. `JSON` serializing

Let's look at `index` in `lib/app/timer.ex`.
You may notice that we are returning a `JSON`
with `json(conn, timers)`.

```elixir
  def index(conn, params) do
    item_id = Map.get(params, "item_id")

    timers = Timer.list_timers(item_id)
    json(conn, timers)
  end
```

However, as it stands, 
[`Jason`](https://github.com/michalmuskala/jason)
(which is the package that serializes and deserializes `JSON` objects),
doesn't know how to encode/decode our `timer` and `item` objects.

We can **derive the implementation**
by specifying which fields should be encoded to `JSON`.
We are going to be using `Jason.Encoder` for this.

In `lib/app/timer.ex`,
add the line on top of the schema, like so.

```elixir
  @derive {Jason.Encoder, only: [:id, :start, :stop]}
  schema "timers" do
    field :start, :naive_datetime
    field :stop, :naive_datetime
    belongs_to :item, Item, references: :id, foreign_key: :item_id

    timestamps()
  end
```

This will allow `Jason` to encode 
any `Timer` struct when returning API calls.

Let's do the same for `Item`!
In `lib/app/timer.ex`,

```elixir
  @derive {Jason.Encoder, only: [:id, :person_id, :status, :text]}
  schema "items" do
    field :person_id, :integer
    field :status, :integer
    field :text, :string

    has_many :timer, Timer
    many_to_many(:tags, Tag, join_through: ItemTag, on_replace: :delete)

    timestamps()
  end
```

By leveraging the `@derive` annotation,
we can easily encode our structs 
and serialize them as `JSON` objects
so they can be returned to the person
using the API! ✨

## 4. Listing `timers` and `items` and validating updates

Let's implement `list_timers/1`
in `lib/app/timer.ex`.

```elixir
  def list_timers(item_id) do
    Timer
    |> where(item_id: ^item_id)
    |> order_by(:id)
    |> Repo.all()
  end
```

Simple, isn't it?
We are just retrieving every `timer` object
of a given `item.id`.

We are also using `Item.get_item/1`
and `Timer.get_timer/1`, 
instead of using 
[bang (!) functions](https://stackoverflow.com/questions/33324302/what-are-elixir-bang-functions).
We are not using bang functions
because they throw Exceptions.
And using `try/rescue` constructs
[isn't a good practice.](https://elixir-lang.org/getting-started/try-catch-and-rescue.html)

To validate parameters and return errors,
we need to be able to "catch" these scenarios.
Therefore, we create non-bang functions
that don't raise exceptions.

In `app/lib/timer.ex`, 
add `get_timer/1`.

```elixir
  def get_timer(id), do: Repo.get(Timer, id)
```

In `app/lib/item.ex`, 
add `get_item/1`.

```elixir
  def get_item(id) do
    Item
    |> Repo.get(id)
    |> Repo.preload(tags: from(t in Tag, order_by: t.text))
  end
```

Digressing,
when updating or creating a `timer`, 
we want to make sure the `stop` field
is not *before* `start`,
as it simply wouldn't make sense!
To fix this (and give the person using the API
an error explaining in case this happens),
we will create our own 
[**changeset datetime validator**](https://hexdocs.pm/ecto/Ecto.Changeset.html#module-validations-and-constraints).

We will going to validate the two dates
being passed and check if `stop > start`.
Inside `lib/app/timer.ex`,
add the following private function.

```elixir
  defp validate_start_before_stop(changeset) do
    start = get_field(changeset, :start)
    stop = get_field(changeset, :stop)

    # If start or stop  is nil, no comparison occurs.
    case is_nil(stop) or is_nil(start) do
      true -> changeset
      false ->
        if NaiveDateTime.compare(start, stop) == :gt do
          add_error(changeset, :start, "cannot be later than 'stop'")
        else
          changeset
        end
    end
  end
```

If `stop` or `start` is `nil`, we can't compare the datetimes,
so we just skip the validation.
This usually happens when creating a timer that is ongoing
(`stop` is `nil`).
We won't block creating `timers` with `stop` with a `nil` value.

Now let's use this validator!
Pipe `start/1` and `update_timer/1`
with our newly created validator,
like so.

```elixir
  def start(attrs \\ %{}) do
    %Timer{}
    |> changeset(attrs)
    |> validate_start_before_stop()
    |> Repo.insert()
  end

  def update_timer(attrs \\ %{}) do
    get_timer!(attrs.id)
    |> changeset(attrs)
    |> validate_start_before_stop()
    |> Repo.update()
  end
```

If you try to create a `timer`
where `start` is *after* `stop`, 
it will error out!

<img width="1339" alt="error_datetimes" src="https://user-images.githubusercontent.com/17494745/212123844-9a03850d-ac31-47a6-a9f4-d32d317f90bb.png">


# And you should be done!

This document is going to be expanded
as development continues.
So if you're reading this, it's because that's all we currently have!

If you found it interesting, 
please let us know by starring the repo on GitHub! ⭐