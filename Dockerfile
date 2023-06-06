# Ruby docker img
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

# Create app folder & go into it
RUN mkdir /url_shortener
WORKDIR /url_shortener

# Copy gemfiles into workdir
COPY Gemfile /url_shortener/Gemfile
COPY Gemfile.lock /url_shortener/Gemfile.lock

# Install gems with bundle
RUN bundle install

# Copy whole app
COPY . /url_shortener

# Add a script to be executed every time the container starts.
RUN chmod -R 777 /url_shortener/db
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
