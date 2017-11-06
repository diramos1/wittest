FROM mpelos/rails-node:5.1.4

RUN apt-get update && \
    apt-get install -y postgresql-client

ENV APP_HOME /app
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 2

COPY . $APP_HOME
