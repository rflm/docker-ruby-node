FROM ubuntu:18.04
LABEL maintainer="maciej@litwiniuk.net"

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev git \
  libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
  libsqlite3-dev libmagickwand-dev imagemagick \
  python apt-utils curl

# Install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 d418483bdd0000576c1370571121a6eb24582116db0b7bb2005e90e250eae418
ADD https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.1.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.7.1.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.7.1.tar.gz && \
  cd ruby-2.7.1 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.7.1 && \
  rm -f ruby-2.7.1.tar.gz

RUN gem install bundler

