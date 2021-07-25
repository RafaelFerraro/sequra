# sequra

## Requirements
`docker`
`docker-compose`

## Setup and running

In order to make things easy, it was decided to use docker and docker-compose to setup, run tests, start the web application and background jobs.

So, first of all, builds the image from the Dockerfile and its development dependencies through docker-compose:

`docker-compose build`

### Database

Before we run the migration command, we have to make sure that the application database is up and running. As we have the database defined as a web application dependency in our services configurations, inside the docker-compose.yml file, it is a good option to start the database by running the web application. In this way, we guarantee that our database initialization is made properly.

`docker-compose run -d web`

The command above will initialize two containers, the web app and the database as its dependency. If you run `docker ps` in your terminal, you should see something like this:

```
$ docker ps
CONTAINER ID   IMAGE        COMMAND                  CREATED         STATUS         PORTS                    NAMES
64fe1ad5bfb5   sequra_web   "bundle exec rackup …"   3 seconds ago   Up 2 seconds   4567/tcp                 sequra_web_run_40f06a006e06
b2d7c9d37a0b   postgres     "docker-entrypoint.s…"   3 seconds ago   Up 2 seconds   0.0.0.0:5432->5432/tcp   sequra_database
```

Now, you can run all of its migrations, by typing `docker exec sequra_web_run_40f06a006e06 rake migrate`.

### Running

To run the tests with rspec, just do:

`docker-compose run rspec`

And, to start the whole application:

`docker-compose up`

This command should start the web application, that will be available through this url: http://localhost:4567, as well as the background job.

## How does it work?

The web application and the background job are going to work in parallel. The job running in the background works like a scheduler, similar to a cron job technically speaking. This job is configured to run once per minute (it can be updated in the `config/sidekiq.yml` file). It’s responsibility is to find orders that were completed in the last week, calculate and generate the disbursements for them.

While that is happening in the background, it’s possible to see the disbursements that have already been created on the browser, through http://localhost:4567/disbursements. 

## What is missing?
  - Api filters to search for disbursements by a given merchant and on a given week. I see two ways to solve that:
    - By applying a query string to the REST endpoint, for example: http://localhost:4567/disbursements?merchant_id=1&date=10/10/2021;
    - By a merchants REST endpoint, for example http://localhost:4567/merchants/1/disbursements?date=10/10/2021;

Some improvements, could be:
- Use Order’s objects, instead of simply Hash objects passing around;
- Use a database instead of only json files to query data;
- Publish domain events for CompletedOrders and calculate the disbursements in a realtime;
- Data validations to check if there already has a disbursement to a specific order, for example.

## Technical choices

#### Architecture
The decision of using a Hexagonal architecture was made in order to develop business rules(domain) without the necessity to care about peripheral things, like which database to use or even if we will use a database or just persist data in a json file, instead. Is the client a web agent or a terminal? The domain doesn't care. If those things change, the domain remains untouchable.

#### Background
As the challenge suggests, it’s better if the disbursement flow happens in the background. Sidekiq makes things easier when we have to work with some background jobs. Sidekiq-scheduler is an “extension” of that, allowing us to schedule jobs to run from time to time. It is my first time using the sidekiq-scheduler. I have already used sidekiq-cron, but this one is a little more complicated to get up and running. I decided to use those libraries in order to automate the disbursements calculation process. Besides that, it’s a safer option than configuring a crontab in the machine.
  
#### Web
The decision to use Sinatra was made because sinatra is simple, lightweight and easy to use. It works well if you just need a simple REST endpoint.
  

