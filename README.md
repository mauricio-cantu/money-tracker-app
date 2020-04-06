<h1 align="center">Money Tracker App :money_with_wings::eyes:</h1>

<p align="center">
  <a href="#question-about">About</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rocket-techs">Techs</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#wrench-setting-up-the-project">Setting up the project</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#notebook-development-notes">Development notes</a>
</p>

## :question: About
Keep track of your money creating accounts and making deposits and transactions between them.

## :rocket: Techs

  - [Elixir](https://elixir-lang.org/)
  - [Phoenix Framework](https://www.phoenixframework.org/)
  - [React](https://reactjs.org/)
  
## :wrench: Setting up the project

### Set up the server

  - `cd` into `api`
  - install dependencies with `mix deps.get`
  - `docker-compose up db` to set up the container containing a MySQL instance
  - `mix ecto.setup` to set up the database
  - `mix phx.server` to run the server (it will be running at [`http://localhost:4000`](http://localhost:4000))
  
### Set up the React app

  - `cd` into `frontend`
  - install dependencies with `yarn install` or `npm install`
  - `yarn start` or `npm start` to run the app (it will be running at [`http://localhost:3000`](http://localhost:3000))

## :notebook: Development notes

 - Code developed following this [Elixir Style Guide](https://github.com/christopheradams/elixir_style_guide)
 - Static code analysis using [Credo](https://github.com/rrrene/credo) (run `mix credo` for results)
 - Used [Notion](https://www.notion.so/) to organize ideas and tasks
 - App made for a code challenge.
