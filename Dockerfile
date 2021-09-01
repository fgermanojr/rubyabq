FROM ruby:3.0.1
# underlying OS should be alpine

# TBD too much postgres, just need end user psql
RUN apt-get update -qq && apt-get install -y build-essential bash postgresql libpq-dev postgresql-client nodejs npm vim libssl-dev curl

# I think there are version issues with this yarn version;
# use npm install instead
# xxx RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# xxx RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get install -y --no-install-recommends yarn

# this is the subdirectory of parent directory
# the parent contains the docker files; the git repo is at the subdir

WORKDIR /rubyabq

RUN nodejs -v
RUN npm -v

# install yarn using npm; then use to install desired js libs
RUN npm install -g yarn
# RUN yarn install --check-files
RUN yarn -v

RUN gem install rails -v=6.0.4

# don't run bundle -B, is that messing up
# RUN rails new . --database=postgresql --webpacker=react

# RUN bundle add rspec-rails
# RUN bundle add react-rails

# RUN rails g react:install
# # RUN rails g react:component HelloWorld name:string
# RUN bundle install --verbose --jobs 20 --retry 5

# there is a series of post rails install steps

EXPOSE 2999

# CMD ["bundle","exec","rails","server",
#                "-p","2999","-b","0.0.0.0"]

CMD ["bash"]

# you always want to do this so you can do
# stuff before starting the server
# so we just run bash and let you run
# the server with rails s -p 2999 -b 0.0.0.0

# This works
# docker build .
#  docker run -v /Users/frankatjackrabbit/src/rubyabq:/rubyabq -it rubyabq_rubyabq  bash
