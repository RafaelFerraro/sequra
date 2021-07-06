FROM ruby:3.0.1

WORKDIR /usr/src/app

COPY . .

RUN bundle install
