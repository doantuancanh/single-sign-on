# pre-build stage
FROM --platform=linux/x86_64 ruby:3.1.0-alpine AS pre-builder

ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}
ENV BUNDLER_VERSION=2.3.3

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}

ENV BUNDLE_PATH="/gems"
RUN apk add --no-cache \
    openssl \
    tar \
    build-base \
    tzdata \
    postgresql-dev \
    postgresql-client \
    git \
  && mkdir -p /var/app \
  && gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apk add --no-cache musl ruby-full ruby-dev gcc make musl-dev openssl openssl-dev g++ linux-headers xz
RUN bundle config set --local force_ruby_platform true

# Do not install development or test gems in production
# RUN if [ "${RAILS_ENV}" = "production" ]; then \
#   bundle config set without 'development test'; bundle install; \
#   else bundle install; \
#   fi

RUN bundle install

COPY . /app

# Remove unnecessary files
RUN rm -rf /gems/ruby/3.1.0/cache/*.gem \
  && find /gems/ruby/3.1.0/gems/ \( -name "*.c" -o -name "*.o" \) -delete

# final build stage
FROM ruby:3.1.0-alpine

ARG BUNDLE_WITHOUT="development:test"
ENV BUNDLE_WITHOUT=${BUNDLE_WITHOUT}
ENV BUNDLER_VERSION=2.3.3

ARG BUNDLE_FORCE_RUBY_PLATFORM=1
ENV BUNDLE_FORCE_RUBY_PLATFORM ${BUNDLE_FORCE_RUBY_PLATFORM}

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}
ENV BUNDLE_PATH="/gems"

ARG DATABASE_NAME="sso"

RUN apk add --no-cache \
    openssl \
    tzdata \
    postgresql-client \
    imagemagick \
    git \
  && gem install bundler

COPY --from=pre-builder /gems/ /gems/
COPY --from=pre-builder /app /app

WORKDIR /app

EXPOSE 3000
