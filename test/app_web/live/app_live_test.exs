defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase
  alias App.{Item, Timer}
  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "done"
    assert render(page_live) =~ "done"
  end

  test "connect and create an item", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render_submit(view, :create,
      %{text: "Learn Elixir", person_id: 1}) =~ "Learn Elixir"
  end

  test "toggle an item", %{conn: conn} do
    {:ok, item} =
      Item.create_item(%{text: "Learn Elixir", status: 2, person_id: 0})
    {:ok, _item2} =
      Item.create_item(%{text: "Learn Elixir", status: 4, person_id: 0})

    assert item.status == 2

    started = NaiveDateTime.utc_now()
    {:ok, _timer} =
      Timer.start(%{item_id: item.id, start: started})

    # See: https://github.com/dwyl/useful/issues/17#issuecomment-1186070198
    # assert Useful.typeof(:timer_id) == "atom"
    assert Item.items_with_timers(1) > 0

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :toggle,
      %{"id" => item.id, "value" => "on"}) =~ "line-through"

    updated_item = Item.get_item!(item.id)
    assert updated_item.status == 4
  end

  test "(soft) delete an item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    assert item.status == 2

    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :delete, %{"id" => item.id}) =~ "done"

    updated_item = Item.get_item!(item.id)
    assert updated_item.status == 6
  end

  test "start a timer", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Get Fancy!", person_id: 0, status: 2})

    assert item.status == 2

    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :start, %{"id" => item.id}) =~ "stop"
  end

  test "stop a timer", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Get Fancy!", person_id: 0, status: 2})

    assert item.status == 2
    started = NaiveDateTime.utc_now()
    {:ok, timer} = Timer.start(%{item_id: item.id, start: started})

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :stop,
      %{"id" => item.id, "timerid" => timer.id}) =~ "done"
  end

  # This test is just to ensure coverage of the handle_info/2 function
  # It's not required but we like to have 100% coverage.
  # https://stackoverflow.com/a/60852290/1148249
  test "handle_info/2 start|stop", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 2})
    started = NaiveDateTime.utc_now()
    {:ok, _timer} = Timer.start(%{item_id: item.id, start: started})

    send(view.pid, %{
      event: "start|stop",
      payload: %{items: Item.items_with_timers(1)}
    })

    assert render(view) =~ item.text
  end

  test "handle_info/2 update", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 2})

    send(view.pid, %{
      event: "update",
      payload: %{items: Item.items_with_timers(1)}
    })

    assert render(view) =~ item.text
  end

  test "handle_info/2 delete", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 6})

    send(view.pid, %{
      event: "delete",
      payload: %{items: Item.items_with_timers(1)}
    })

    refute render(view) =~ item.text
  end

  test "edit-item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, "edit-item", %{"id" => Integer.to_string(item.id)}) =~
             "<form phx-submit=\"update-item\" id=\"form-update\""
  end

  test "update an item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    {:ok, view, _html} = live(conn, "/")

    assert render_submit(view, "update-item", %{"id" => item.id, "text" => "Learn more Elixir"}) =~
             "Learn more Elixir"

    updated_item = Item.get_item!(item.id)
    assert updated_item.text == "Learn more Elixir"
  end

  test "timer_text(start, stop)" do
    timer = %{
      start: ~N[2022-07-17 09:01:42.000000],
      stop: ~N[2022-07-17 13:22:24.000000]
    }

    assert AppWeb.AppLive.timer_text(timer) == "04:20:42"
  end

  test "get / with valid JWT", %{conn: conn} do
    data = %{email: "test@dwyl.com", givenName: "Alex", picture: "this", auth_provider: "GitHub", id: 2}
    jwt = AuthPlug.Token.generate_jwt!(data)

    {:ok, view, _html} = live(conn, "/?jwt=#{jwt}")
    assert render(view)
  end

  test "Logout link displayed when loggedin", %{conn: conn} do
    data = %{email: "test@dwyl.com", givenName: "Alex", picture: "this", auth_provider: "GitHub", id: 2}
    jwt = AuthPlug.Token.generate_jwt!(data)

    conn = get(conn, "/?jwt=#{jwt}")
    assert html_response(conn, 200) =~ "logout"
  end

  test "get /logout with valid JWT", %{conn: conn} do
    data = %{
      email: "test@dwyl.com",
      givenName: "Alex",
      picture: "this",
      auth_provider: "GitHub",
      sid: 1,
      id: 2
    }

    jwt = AuthPlug.Token.generate_jwt!(data)

    conn =
      conn
      |> put_req_header("authorization", jwt)
      |> get("/logout")

    assert "/" = redirected_to(conn, 302)
  end

  test "test login link redirect to auth.dwyl.com", %{conn: conn} do
    conn = get(conn, "/login")
    assert redirected_to(conn, 302) =~ "auth.dwyl.com"
  end
end