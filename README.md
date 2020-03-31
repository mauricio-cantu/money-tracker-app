# Money Tracker App
App to manage money accounts (create accounts, transactions and deposits).

## Techs

  * REST API built with Elixir and Phoenix Framework
  * Web app built with React
  * MySQL database
  
## Setting up the project

### Set up the server

  * cd into `api`
  * install dependencies with `mix deps.get`
  * `docker-compose up db` to set up the container containing a MySQL instance
  * `mix ecto.setup` to set up the database
  * `mix phx.server` to run the server (it will be running at [`http://localhost:4000`](http://localhost:4000))
  
### Set up the react app

  * cd into `frontend`
  * install dependencies with `yarn install` or `npm install`
  * `yarn start` or `npm start` to run the app (it will be running at [`http://localhost:3000`](http://localhost:3000))

