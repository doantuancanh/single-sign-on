# pre-build stage
FROM --platform=linux/x86_64 ruby:3.1.0-alpine AS pre-builder

ENV BUNDLE_PATH="/gems"
RUN apk add --no-cache \
    openssl \
    tar \
    build-base \
    tzdata \
    postgresql-dev \
    postgresql-client \
    git \
    yarn \
  && mkdir -p /var/app \
  && gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apk add --no-cache musl ruby-full ruby-dev gcc make musl-dev openssl openssl-dev g++ linux-headers xz
RUN bundle config set --local force_ruby_platform true

RUN bundle install

COPY package.json ./
RUN yarn install

COPY . /app

# Remove unnecessary files
RUN rm -rf /gems/ruby/3.1.0/cache/*.gem \
  && find /gems/ruby/3.1.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

# final build stage
FROM ruby:3.1.0-alpine

ENV BUNDLE_PATH="/gems"

ARG DATABASE_NAME="sso"

RUN apk add --no-cache \
    openssl \
    tzdata \
    postgresql-client \
    imagemagick \
    git \
    yarn \
  && gem install bundler

COPY --from=pre-builder /gems/ /gems/
COPY --from=pre-builder /app /app

WORKDIR /app

EXPOSE 3000
