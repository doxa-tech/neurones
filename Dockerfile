FROM ruby:2.3.1-slim

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs git

ENV APP_HOME /var/www/neurones

RUN mkdir -p $APP_HOME
RUN mkdir -p $APP_HOME/tmp/pids

WORKDIR $APP_HOME

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

RUN bundle exec rake assets:precompile

CMD bundle exec rails s -b 0.0.0.0
