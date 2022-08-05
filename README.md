<div align="center">

# @dwyl App MVP  💡⏳ ✅

The most basic implementation
of the **@dwyl App**
[**MVP** feature set](https://github.com/dwyl/app/issues/266).

# _Please `try` it_: [mvp.fly.dev](https://mvp.fly.dev/) 🙏

And help us to ...

<a href="https://agilevelocity.com/product-owner/mvp-mmf-psi-wtf-part-one-understanding-the-mvp">
  <img src="https://user-images.githubusercontent.com/194400/65666966-b28dbd00-e036-11e9-9d11-1f5d3e22258e.png" width="500" alt="MVP Loop">
</a>

[![Build Status](https://img.shields.io/travis/com/dwyl/app-mvp-phoenix/master?color=bright-green&style=flat-square)](https://travis-ci.org/dwyl/app-mvp-phoenix)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/app-mvp-phoenix/master.svg?style=flat-square)](https://codecov.io/github/dwyl/app-mvp-phoenix?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)](https://hex.pm/packages/elixir_auth_google)
[![contributions welcome](https://img.shields.io/badge/feedback-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/app-mvp-phoenix/issues)
[![HitCount](https://hits.dwyl.com/dwyl/app-mvp-phoenix.svg)](https://hits.dwyl.com/dwyl/app-mvp-phoenix)


</div>

- [@dwyl App MVP  💡⏳ ✅](#dwyl-app-mvp---)
- [_Please `try` it_: mvp.fly.dev 🙏](#please-try-it-mvpflydev-)
- [Why? 🤷](#why-)
- [_What_? 💭](#what-)
  - [MVP?](#mvp)
  - [Combining Features of Several Apps](#combining-features-of-several-apps)
    - [Startup Ideas? 💡](#startup-ideas-)
  - [2 Apps into _One_](#2-apps-into-one)
  - [Proposed MVP UI/UX](#proposed-mvp-uiux)
- [_Who?_ 👥](#who-)
  - [Feedback! 🙏](#feedback-)
    - [Perform Some Actions in the App](#perform-some-actions-in-the-app)
  - [Contributing 👩‍💻](#contributing-)
    - [More Features?](#more-features)
  - [Build Your Own Idea!](#build-your-own-idea)
- [_How_? 💻](#how-)
  - [Tech Stack?](#tech-stack)
  - [Run the MVP App on your `localhost` ⬇️](#run-the-mvp-app-on-your-localhost-️)
- [Build Log 👩‍💻](#build-log-)
  - [1. Create a New `Phoenix` App](#1-create-a-new-phoenix-app)
    - [1.1 Run the `Phoenix` App](#11-run-the-phoenix-app)
    - [1.2 Run the tests:](#12-run-the-tests)
      - [Test Coverage?](#test-coverage)
    - [1.3 Setup `Tailwind`](#13-setup-tailwind)
    - [1.4 Setup `LiveView`](#14-setup-liveview)
    - [1.5 Update `router.ex`](#15-update-routerex)
    - [1.6 Update Tests](#16-update-tests)
    - [1.7 Delete Page-related Files](#17-delete-page-related-files)
  - [2. Create Schemas to Store Data](#2-create-schemas-to-store-data)
    - [_Explanation_ of the Schemas](#explanation-of-the-schemas)
      - [`people`](#people)
      - [`item`](#item)
      - [`timer`](#timer)
    - [2.1 Run Tests!](#21-run-tests)
  - [3. Input Items!](#3-input-items)
    - [3.1 Hard-code `item.person_id`](#31-hard-code-itemperson_id)
  - [4. Add Authentication](#4-add-authentication)

# Why? 🤷

Our goal with this 
[MVP](https://github.com/dwyl/technical-glossary/issues/44)
is to build the **minimal _useable_ App** <br />
that covers our basic "***Capture, Categorize, Complete***"
[**workflow**](https://github.com/dwyl/product-roadmap#what). <br />
It is well-documented, tested
and easy for a beginner to run & understand.

The idea is to _ship_ this App to
Fly: 
[mvp.fly.dev](https://mvp.fly.dev/)
and then _use/test_ it (_internally_). <br />
Once we have collected initial feedback,
we can share it with the world!

Once the MVP features are complete,
the code will be merged
into the main
[dwyl/**app**](https://github.com/dwyl/app) 
repo.<br />
However we will also maintian this repo
as a **reference** for **new joiners** <br />
wanting the **most _basic_ version**
of the app to **learn** from.

# _What_? 💭

A **mobile-first** 
**_hybrid_**
**task and activity** (time)
**tracking tool**.
<!-- with built-in (basic) team **communication**. -->
## MVP? 

A Minimum Viable Product ("MVP")


## Combining Features of Several Apps

We've found it _tedious_ 
to use **several _separate_ apps**
for task and time tracking 🤦‍♂️ <br />
and think it's _logical_ 
to _combine_ the functionality. 💡

If the idea of **_combining_ related tools**
appeals to you keep reading. 😍<br />
If it sounds like a _terrible_ idea to you,
please just ignore it and get on with your day. 👌

> “_If at first the **idea** is **not absurd**,
then there is **no hope** for it._”
~ [Albert Einstein](https://www.goodreads.com/quotes/110518-if-at-first-the-idea-is-not-absurd-then-there)

### Startup Ideas? 💡

We _love_ talking about startup ideas. ❤️ 🎉 <br />
If you are new to this, 
we recommend watching the following
[YC](https://www.ycombinator.com/)
videos:

+ Jared Friedman's
_How to Get Startup Ideas_:
[youtu.be/uvw-u99yj8w](https://youtu.be/uvw-u99yj8w?t=424)
and <br />
+ Michael Seibel's
_How to Get and Test Startup Ideas_:
[youtu.be/vDXkpJw16os](https://youtu.be/vDXkpJw16os)
+ Kevin Hale's _How to Evaluate Startup Ideas_:
https://youtu.be/DOtCl5PU8F0


## 2 Apps into _One_

This MVP combines **2 apps** into ***one***. <br />
We **built** the 2 _separate_ apps
to showcase the individual features:

1. Todo list: 
   [github.com/dwyl/phoenix-liveview-**todo-list**](https://github.com/dwyl/phoenix-liveview-todo-list-tutorial)
2. Stop Watch (Timer):
   [github.com/dwyl/phoenix-liveview-**stopwatch**](https://github.com/dwyl/phoenix-liveview-stopwatch)
<!--
3. Chat (Communication): 
   [github.com/dwyl/phoenix-liveview-**chat**](https://github.com/dwyl/phoenix-liveview-chat-example)
--> 

We encourage people to read 
and understand the individual feature Apps
from first principals
***`before`***
trying run the MVP. 
But our _hope_ is that
the UI/UX in the MVP
is sufficiently intuitive
that it **_immediately_ makes sense**. 🤞

## Proposed MVP UI/UX

This is our wireframe UI/UX
we used as the _guide_ 
to create the MVP functionality:

![mvp-proposed-ux](https://user-images.githubusercontent.com/194400/73374277-d9445480-42b1-11ea-980a-3fabbfe5a9fd.png)

It is _deliberately_ "basic" 
and 
["ugly"](https://youtu.be/m4isFputh68?t=158)
so we don't focus on aesthetics. 🚀<br />
It will _definitely_ change over time 
as we _use_ the App 
and collect _feedback_. 💬<br />
If you want to _help_ make it better,
share your feedback! 🙏

Way more detail on the features: 
[dwyl/app/issues/265](https://github.com/dwyl/app/issues/265)

<!--
> **Note**: This UI/UX _appears_ 
> to only cover the **`Todo List`** and **`Timer`** features.
> That is a valid observation.
> Hopefully you can use your imagination
> to think of how **`Communication`**
> can be integrated into this.
> If you can't imagine it,
> but are still curious,
> ***subscribe*** as we will cover it later on!

> The "communication" aspect will be 
> covered by having 
> [***`presence`***](https://github.com/dwyl/phoenix-liveview-chat-example#14-presence)
> in the App.
> i.e. knowing **who** 
> is using/viewing the App at any given time
> with appropriate privacy controls.
> Simply knowing that someone is online (_or not_)
> and what they are working on 
> is a _huge_ boost to team communication
> without the constant distraction/interruption of **Chat**.
> Later (post-MVP) we will implement a very _basic_ Chat feature,
> but it will be _nothing_ like the 
> [Slack](https://github.com/dwyl/app/issues/205)
> or other DeepWork killing Chat Apps.
-->

# _Who?_ 👥

This **MVP** has **_two_ target audiences**:

1. **@dwyl team** to start 
  ["dogfooding"](https://en.wikipedia.org/wiki/Eating_your_own_dog_food)
  the basic workflow in our App. <br />
  It's meant to work for _us_
  and have just enough functionality 
  to solve our _basic_ needs.

2. **Wider community** of people 
  who want to see a 
  **_fully_-functioning `Phoenix` app**
  with good documentation and testing.

_Longer_ term, the MVP 
will also help future @dwyl team members
get 
[**up-to-speed**](https://dictionary.cambridge.org/dictionary/english/up-to-speed) 
on our App & Stack **_much_ faster**.
Understanding the basics in _this_ app
will be an _excellent_ starting point.

## Feedback! 🙏

Your feedback is very much encouraged/welcome! 💬<br />
If you find the repo interesting/useful, please ⭐ on GitHub. <br />
And if you have any questions,
please open an issue:
[app-mvp/issues](https://github.com/dwyl/app-mvp/issues) ❓
<br />


### Perform Some Actions in the App

Please visit 
[`mvp.fly.dev`](https://mvp.fly.dev/) 
(_or run the app on your `localhost` - see below_) <br />
and perform some actions to test the App:

1. ***Create*** a todo list `item`; <br />
   > Note: this item is **`public`** (anyone can see it!) <br />
   If you want **`private`** items you need to **login**. 
2. ***Start*** a `timer` for the (`public`) `item`
3. ***Stop*** the `timer` for the `item` (press **`start`**)
4. ***Mark*** the `item` as `done` (press/tap the `checkbox` to the left of the `item.text`)
5. ***`Archive`*** the `item` (it will disappear)
6. ***Create*** a new (`public`) `item`
7. ***Start*** a `timer` for the (`public`) `item` and leave it running.
8. ***Login*** using your **`GitHub`** or **`Google`** account.
9.  ***Create*** a todo list `item` while logged-in
10. ***Start*** a `timer` for the `item`
11. ***Stop*** the `timer`
12. ***Resume*** the `timer` that was previously stopped.
13. ***Create*** a `new` (`private`) todo list `item` while logged-in
14. ***Start*** a `timer` for the `item`
15. ***Open*** a second web browser and watch the ***realtime sync***!
16. ***Edit*** the `item.text` for the timer that is already running.
17. ***Mark*** the (`private`) `item` as `done` and see the time it took.
18. ***`Archive`*** the `item`
19. ***Logout*** of the app
20. ***View*** the (`public`) `item` you created earlier with the `timer` still runinng.

That's it. 
The MVP in a nutshell. 
Here's a GIF if you're low on time:

![mvp-fly-auth](https://user-images.githubusercontent.com/194400/180079997-b43a24c2-7a50-4755-aef9-ef3f2aa28816.gif)


<!--
If you are using the "full" @dwyl App,
and have a question/idea,
please open an issue in:
[app/issues](https://github.com/dwyl/app/issues)
-->

## Contributing 👩‍💻

All contributions 
from typo fixes
to feature enhancements
are always welcome! 🙌

Please start by: <br />
a. **Star** the repo on GitHub 
  so you have a "bookmark" you can return to. ⭐ <br />
b. **Fork** the repo 
  so you have a copy you can "hack" on. 🍴 <br />
c. **Clone** the repo to your `localhost` 
  and run it! (see below) 👩‍💻 <br />


For more detail,
please see:
[github.com/dwyl/contributing](https://github.com/dwyl/contributing)

### More Features? 

Please note that our goal with this MVP
is _not_ to have _all_ the features. 


## Build Your Own Idea! 

We are building this MVP App for _ourselves_
because we have felt the 
[_pain_](https://github.com/dwyl/app/issues/213#issuecomment-650531694)
of _not_ having the App.

![nelson-persona](https://user-images.githubusercontent.com/194400/85919307-faf63780-b861-11ea-959c-6a16f0d251fb.png)


<br />

# _How_? 💻

Our goal is 
to document as much 
of the implementation as possible,
so that _anyone_ 
can follow along.

If you spot a gap in the docs,
please


## Tech Stack? 

This **MVP** app uses the **`PETAL` Stack**
described in: 
[dwyl/**technology-stack**](https://github.com/dwyl/technology-stack)

Going through the individual feature apps listed above,
will give you the knowledge
to understand this MVP.

If you have _any_ coding skills 
(e.g: `JavaScript`, `Java`,  `Python`, `Ruby`, `PHP`, `SQL`, etc.)
you will be able to follow along
without any issues
as the code is **_deliberately_ simple**.

## Run the MVP App on your `localhost` ⬇️

> **Note**: You will need to have 
**`Elixir`** and **`Postgres` installed**, <br />
see: 
[learn-elixir#installation](https://github.com/dwyl/learn-elixir#installation)
and 
[learn-postgresql#installation](https://github.com/dwyl/learn-postgresql#installation)

> **Tip**: check the prerequisites in:
> [**/phoenix-chat-example**](https://github.com/dwyl/phoenix-chat-example#0-pre-requisites-before-you-start)

On your `localhost`, 
run the following commands 
in your terminal:

```sh
git clone git@github.com:dwyl/app-mvp-phoenix.git && cd app-mvp-phoenix
source .env_sample
mix setup
```
That will download the MVP code, 
install dependencies
and create the necessary database + tables.

The line 
`source .env_sample` 
loads the environment variables 
required for the
application to run.



<!--
If for any reason you have an error while running the setup, try to rebuild/compile
the application by deleting the existing `_build` folder and running the `setup` again:

```sh
rm -r _build
mix setup
```


## _Single_ Environment Variable: `AUTH_API_KEY`

Follow the instructions in **Step 2** of
[**`auth_plug`**](https://github.com/dwyl/auth_plug#2-get-your-auth_api_key-)
to create your 
**`AUTH_API_KEY`**.

-->

Once the `mix setup` command completes,
you can run the app with:

```sh
mix s
```

Open the App in your web browser
and start your tour! 

<br />

# Build Log 👩‍💻

This is a log 
of the steps taken 
to build the MVP. <br />
It took us _hours_ 
to write it,
but you can ***speed-run*** it 
in **20 minutes**. 🏁

> **Note**: we have referenced sections 
> in our more extensive tutorials/examples
> to keep this doc brief
> and avoid duplication.
> You don't have to follow every step in
> the other tutorials/examples,
> but they are linked in case you get stuck.

## 1. Create a New `Phoenix` App

Open your terminal and 
**create** a **new `Phoenix` app**
with the following command:

```sh
mix phx.new app --no-mailer --no-dashboard --no-gettext
```

When asked to install the dependencies,
type `Y` and `[Enter]` (_to install everything_).

The MVP won't be 
send emails,
display dashboards 
or translate to other languages
(sorry).
However _all_ of those things 
will be in the _main_ 
[dwyl/**app**](https://github.com/dwyl/app)
we're just excluding them here
to reduce complexity/dependencies.

### 1.1 Run the `Phoenix` App

Run the `Phoenix` app with the command:

```sh
mix phx.server
```

You should see output similar to the following in your terminal:
```sh
Generated app app
[info] Running AppWeb.Endpoint with cowboy 2.9.0 at 127.0.0.1:4000 (http)
[info] Access AppWeb.Endpoint at http://localhost:4000
[debug] Downloading esbuild from https://registry.npmjs.org/esbuild-darwin-64/-/esbuild-darwin-64-0.14.29.tgz
[watch] build finished, watching for changes...
```

That's a good sign, `esbuild` was downloaded
and the assets were compiled successfully.

Visit 
[`localhost:4000`](http://localhost:4000) 
from your browser.

You should see something similar to the following 
(default `Phoenix` homepage):

![phoenix-default-homepage](https://user-images.githubusercontent.com/194400/174807257-34120dc5-723e-4b2c-9e8e-4b6f3aefca14.png)


### 1.2 Run the tests:

To run the tests with 


You should see output similar to:

```sh
...

Finished in 0.1 seconds (0.07s async, 0.07s sync)
3 tests, 0 failures
```

That tells us everything is working as expected. 🚀


#### Test Coverage?

If you prefer to see **test coverage** - we certainly do -
then you will need to add a few lines to the 
[`mix.exs`](https://github.com/dwyl/app-mvp-phoenix/blob/main/mix.exs)
file and
create a 
[`coveralls.json`](https://github.com/dwyl/app-mvp-phoenix/blob/main/coveralls.json)
file to exclude `Phoenix` files from `excoveralls` checking.
Add alias (shortcuts) in `mix.exs` `defp aliases do` list.
e.g: `mix c` runs `mix coveralls.html` 
see: [**`commits/d6ab5ef`**](https://github.com/dwyl/app-mvp-phoenix/pull/90/commits/d6ab5ef7c2be5dcad7d060e782393ae29c94a526) ...

This is just standard `Phoenix` project setup for us, 
so we don't duplicate any of the steps here.
For more detail, please see:
[Automated Testing](https://github.com/dwyl/phoenix-chat-example#testing-our-app-automated-testing)
in the 
[dwyl/phoenix-chat-example](https://github.com/dwyl/phoenix-chat-example#testing-our-app-automated-testing)
and specifically
[What is _not_ tested?](https://github.com/dwyl/phoenix-chat-example#13-what-is-not-tested)

With that setup, run:

```sh
mix c
```

You should see output similar to the following:

<img width="653" alt="Phoenix tests passing coverage 100%" src="https://user-images.githubusercontent.com/194400/175767439-4f609357-24c0-4975-a3d4-6ed6057bb321.png">


### 1.3 Setup `Tailwind`

As we're using **`Tailwind CSS`**
for the **UI** in this project
we need to enable it.

We are not duplicating the instructions here,
please refer to:
[Tailwind in Phoenix](https://github.com/dwyl/learn-tailwind#part-2-tailwind-in-phoenix).
Should only take **`~1 minute`**.

By the end of this step you should have **`Tailwind`** working.
When you visit 
[`localhost:4000`](http://localhost:4000) 
in your browser, 
you should see: 

![hello world tailwind phoenix](https://user-images.githubusercontent.com/194400/174838767-20bf201e-3179-4ff9-8d5d-751295d1d069.png)

If you got stuck in this section,
please retrace the steps
and open an issue:
[learn-tailwind/issues](https://github.com/dwyl/learn-tailwind/issues)

### 1.4 Setup `LiveView`

Create the `lib/app_web/live` directory
and the controller at `lib/app_web/live/app_live.ex`:

```elixir
defmodule AppWeb.AppLive do
  use AppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
```

Create the `lib/app_web/views/app_view.ex` file:

```elixir
defmodule AppWeb.AppView do
  use AppWeb, :view
end
```

Next, create the
**`lib/app_web/live/app_live.html.heex`**
file 
and add the following line of `HTML`:

```html
<h1 class="">LiveView App Page!</h1>
```

Finally, to make the **root layout** simpler, 
open the 
`lib/app_web/templates/layout/root.html.heex`
file and 
update the contents of the `<body>` to:

```html
<body>
  <header>
    <section class="container">
      <h1>App MVP Phoenix</h1>
    </section>
  </header>
  <%= @inner_content %>
</body>
```

### 1.5 Update `router.ex`

Now that you've created the necessary files,
open the router
`lib/app_web/router.ex` 
replace the default route `PageController` controller:

```elixir
get "/", PageController, :index
```

with `AppLive` controller:


```elixir
scope "/", AppWeb do
  pipe_through :browser

  live "/", AppLive
end
```

Now if you refresh the page 
you should see the following:

![liveveiw-page-with-tailwind-style](https://user-images.githubusercontent.com/194400/176137805-34467c88-add2-487f-9593-931d0314df62.png)

### 1.6 Update Tests

At this point we have made a few changes 
that mean our automated test suite will no longer pass ... 
Run the tests in your command line with the following command:

```sh
mix test
```

You should see the tests fail:

```sh
..

  1) test GET / (AppWeb.PageControllerTest)
     test/app_web/controllers/page_controller_test.exs:4
     Assertion with =~ failed
     code:  assert html_response(conn, 200) =~ "Hello TailWorld!"
     left:  "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
     <main class=\"container\">
     <h1 class=\"text-6xl text-center\">LiveView App Page!</h1>\n</main></div>
     </body>\n</html>"
     right: "Hello TailWorld!"
     stacktrace:
       test/app_web/controllers/page_controller_test.exs:6: (test)

Finished in 0.1 seconds (0.06s async, 0.1s sync)
3 tests, 1 failure
```

Create a new directory: `test/app_web/live`

Then create the file: 
`test/app_web/live/app_live_test.exs`

With the following content:

```elixir
defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "LiveView App Page!"
  end
end
```

Save the file 
and re-run the tests: `mix test`

You should see output similar to the following:

```sh
Generated app app
The database for App.Repo has been dropped
...

Finished in 0.1 seconds (0.08s async, 0.1s sync)
3 tests, 0 failures

Randomized with seed 796477
```

### 1.7 Delete Page-related Files

Since we won't be using the `page` meatphore in our App, 
we can delete the default files created by `Phoenix`:

```sh
lib/app_web/views/page_view.ex
lib/app_web/controllers/page_controller.ex
lib/app_web/templates/page/index.html.heex
test/app_web/controllers/page_controller_test.exs
```

With those files deleted,
our **`Phoenix + LiveView`** project 
is now fully setup
and ready to start _building_!

<!-- temp commenting this out as it's a bit of a side-track ...

### Side Note: _Data_-first Design 💡

There are _several_ ways to design and build Apps.
One of the popular approaches 
is to start by trying to define the UI/UX
e.g: by creating a wireframe in **`Figma`**.
This makes an implicit assumption
about how we expect people to interact
with the App.
We often build Apps UI/UX-first
because moving boxes/buttons & text 
around in a low-fidelity wireframe
is a _lot_ cheaper/easier/faster
than writing code. 
However when we are doing an _exploratory_
MVP tightly defining the UI/UX
can create regidity too early.
Another approach is to think about the 
**`data`** we want to capture
and how we may want 
to _transform_ that **`data`**.

For a _much_ more elequent
explanation of why **`data`** first
development makese sense,
watch
"Make Data Structures" 
by Richard Feldman:
https://youtu.be/x1FU3e0sT1I
You don't need to know _any_ `Elm`
to watch this talk.

-->

## 2. Create Schemas to Store Data

Create database schemas 
to store the data.
Run the following 
[**`mix phx.gen.schema`**](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)
commands:

```sh
mix phx.gen.schema Person people givenName:binary auth_provider:string key_id:integer status:integer picture:binary locale:string
mix phx.gen.schema Item items text:string person_id:references:people status:integer
mix phx.gen.schema Timer timers item_id:references:items start:naive_datetime stop:naive_datetime person_id:references:people
```

At the end of this step,
we have the following database
[Entity Relationship Diagram](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model)
(ERD):

![mvp-erd-people-items-timers](https://user-images.githubusercontent.com/194400/180363191-79c0621b-04a1-4b0e-81e1-51345cc2e86d.png)

<!-- probably not needed ...
> **Note**: We used 
> [**`mix phx.gen.schema`**](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)
> instead of the
[`phx.gen.html`](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Html.html)
generator which creates a _lot_ of 
[boilerplate code](https://github.com/dwyl/app-mvp-phoenix/issues/89#issuecomment-1167548207).
-->

We created **3 database tables**;
`items`, `people` and `timers`.
Let's run through them.

### _Explanation_ of the Schemas

This is a quick breakdown of the schemas created above:
#### `people`

The **`people`** (or `person`) _using_ the App
(AKA the ["user"](https://github.com/dwyl/app/issues/33)).

+ `id`: `Int`<sup>1</sup>
+ `inserted_at`: `Timestamp` - created/managed by `Phoenix/Ecto`
+ `updated_at`: `Timestamp`
+ `givenName`: `Binary` (_encrypted_) - first name of a person
 https://schema.org/Person
+ `auth_provider`: `String` - so we can contact the person by email duh.
+ `email_hash`: `Binary` (_salted & hashed for quick lookup_)
+ `key_id`: `String` - the `ID` of the encryption key
used to encrypt personal data (NOT the key itself!)
see:
[dwyl/phoenix-ecto-**encryption**-**example**](https://github.com/dwyl/phoenix-ecto-encryption-example)
+ `status`: `Integer` - e.g: "0: unverified, 1: verified", etc.
  For the list of available statuses, 
  please see: 
  [github.com/dwyl/statuses](https://github.com/dwyl/statuses)

We will use the **`people`** schema
later on when we add Authentication.
We're just setting it all up now
so that both **`items`** and **`timer`** 
belong to a **`person`** from the start.

#### `item`

An `item` is the most basic unit of content.
An **`item`** is just a **`String`** of **`text`**.
Later we will be able to 
e.g: a "note", "task", "reminder", etc.
The name **`item`** is **_deliberately_ generic**
as it maintains complete flexibility 
for what we are building later on.

+ `id`: `Int` - the auto-incrementing `id`.
+ `inserted_at`: `NaiveDateTime` - created/managed by `Phoenix`
+ `updated_at`: `NaiveDateTime`
+ `text`: `Binary` (_encrypted_) - the free text you want to capture.
+ `person_id`: `Integer` 
    `person.id` the "owner" of the `item`)
+ `status`: `Integer`  the `status` of the `item` 
  e.g: "in progress"

#### `timer`

A `timer` is attached to an `item`
to track how long it takes to ***complete***.

  + `id`: `Int`
  + `inserted_at`: `NaiveDateTime`
  + `updated_at`: `NaiveDateTime`
  + `item_id` (FK item.id)
  + `start`: `NaiveDateTime` - time started on device
  + `stop`: `NaiveDateTime` - time ended on device

An `item` can have zero or more `timers`.
Each time a `item` (`task`) is worked on
a **_new_ `timer`** is created/started (_and stopped_).
Meaning a `person` can split the completion 
of an `item` (`task`) across multiple sessions.
That allows us to get a running total
of the amount of time that has
been taken.

<!--
> **Note**: 
> The point of having a distinct `start` and `stop`
instead of just reusing the `inserted_at`
and `updated_at` is simple:
it will allow people to set their timer `start` and/or `stop`
to a different time than the automatic one. 
But they will not be able to update the `inserted_at` or `updated_at`
so we always know when the record was created/updated.
-->



<br />

### 2.1 Run Tests!

Once we've created the required schemas,
several new files are created.
If we run the tests with coverage:

```sh
mix c
```

We note that the test coverage 
has dropped considerably:

```sh
Finished in 0.1 seconds (0.08s async, 0.09s sync)
3 tests, 0 failures

----------------
COV    FILE                                        LINES RELEVANT   MISSED
  0.0% lib/app/item.ex                                19        2        2
  0.0% lib/app/person.ex                              22        2        2
  0.0% lib/app/timer.ex                               20        2        2
100.0% lib/app_web/live/app_live.ex                   11        2        0
100.0% lib/app_web/router.ex                          18        2        0
100.0% lib/app_web/views/error_view.ex                16        1        0
[TOTAL]  38.5%
----------------
```

Specifically the files:
`lib/app/item.ex`, 
`lib/app/person.ex`, 
and 
`lib/app/timer.ex`
have **_zero_ test coverage**. 

We will address this test coverage shortfall in the next section.
Yes, we _know_ this is not 
["TDD"](https://github.com/dwyl/learn-tdd#what-is-tdd)
because we aren't writing the tests _first_.
But by creating database schemas,
we have a scaffold 
for the next stage.
See: https://en.wikipedia.org/wiki/Scaffold_(programming)

<br />

## 3. Input Items!

Create the directory `test/app`
and file:
`test/app/item_test.exs`
with the following code:

```elixir
defmodule App.ItemTest do
  use App.DataCase
  alias App.Item

  describe "items" do
    @valid_attrs %{text: "some text", person_id: 1, status: 2}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    test "get_item!/1 returns the item with given id" do
      {:ok, item} = Item.create_item(@valid_attrs)
      assert Item.get_item!(item.id).text == item.text
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Item.create_item(@valid_attrs)

      assert item.text == "some text"

      inserted_item = List.first(Item.list_items())
      assert inserted_item.text == @valid_attrs.text
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Item.create_item(@invalid_attrs)
    end

    test "list_items/0 returns a list of items stored in the DB" do
      {:ok, _item1} = Item.create_item(@valid_attrs)
      {:ok, _item2} = Item.create_item(@valid_attrs)
      items = Item.list_items()
      assert Enum.count(items) == 2
    end

    test "update_item/2 with valid data updates the item" do
      {:ok, item} = Item.create_item(@valid_attrs)

      assert {:ok, %Item{} = item} = Item.update_item(item, @update_attrs)
      assert item.text == "some updated text"
    end
  end
end
```



### 3.1 Hard-code `item.person_id`






## 4. Add Authentication



