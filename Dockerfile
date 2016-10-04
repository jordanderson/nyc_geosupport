FROM ruby:2.3.1

ENV BUNDLER_VERSION 1.12.5
ENV RUBYGEMS_VERSION 2.6.6
ENV BUNDLE_BIN_PATH $BUNDLE_BIN
ENV BUNDLE_GEMFILE=/app/Gemfile BUNDLE_JOBS=2 BUNDLE_PATH=/bundle
RUN gem update --system $RUBYGEMS_VERSION
RUN gem install bundler --version $BUNDLER_VERSION

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget unzip git build-essential

RUN mkdir /nyc_geosupport

WORKDIR /nyc_geosupport

RUN wget http://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/gdelx_16a.zip \
    && unzip gdelx_16a.zip \
    && rm gdelx_16a.zip

ENV GEOSUPPORT_HOME=/nyc_geosupport/version-16a_15.4
ENV LD_LIBRARY_PATH=$GEOSUPPORT_HOME/lib/
ENV GS_INCLUDE_PATH=$GEOSUPPORT_HOME/include/foruser
ENV GS_LIBRARY_PATH=$GEOSUPPORT_HOME/lib
ENV GEOFILES=$GEOSUPPORT_HOME/fls/
ENV LIBGEO_PATH=$GS_LIBRARY_PATH/libgeo.so

RUN gem install ffi

ADD . /nyc_geosupport

RUN rake build
RUN rake install

CMD "irb"
