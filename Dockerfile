FROM ruby:3.1.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install
RUN apt-get update && apt-get install -y postgresql-client

COPY . .

CMD ["ruby", "server.rb"]
