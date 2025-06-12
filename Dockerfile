FROM ruby:3.3.0-slim

ENV RAILS_ENV production
ENV NODE_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

RUN apt update && apt install -y build-essential \
                                  libpq-dev \
                                  tzdata

# Node and friends
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt install -y nodejs npm

# Ruby dependencies
COPY Gemfile* /app/
WORKDIR /app
RUN gem install bundler
RUN bundle config set without 'development test'
RUN bundle install

# JavaScript dependencies
COPY package.json /app/
COPY package-lock.json /app/
RUN npm install

COPY . /app/

ENV SECRET_KEY_BASE $(bin/rails secret)
RUN bin/rails assets:precompile

CMD ["./bin/rails", "s", "-b", "0.0.0.0"]
