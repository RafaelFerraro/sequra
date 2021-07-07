FROM ruby:3.0.1

WORKDIR /usr/src/app

COPY . .

RUN bundle install

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
