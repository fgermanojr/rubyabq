FROM ruby:3.0.1
# underlying OS should be alpine, but appears to be debian 10

# TBD too much postgres, just need end user stuff for psql
RUN apt-get update -qq && apt-get install -y build-essential bash postgresql libpq-dev postgresql-client nodejs npm vim libssl-dev curl

# I think there are version issues with this yarn version;
# use npm install instead
# xxx RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# xxx RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get install -y --no-install-recommends yarn

WORKDIR /rubyabq

RUN nodejs -v
RUN npm -v

# install yarn using npm; then use to install desired js libs
RUN npm install -g yarn
# RUN yarn install --check-files
RUN yarn -v

RUN gem install rails -v=6.0.4

# dot builds in current directory
RUN rails new . --database=postgresql --webpacker=react
# rails new runs a bundle install at the end.
# docker exec -it rubyabq_web_1 bash
# do this manually so rspec-rails is added to development, test
# RUN bundle add rspec-rails
# RUN bundle add react-rails

# # had to run manually
# RUN rails webpacker:install
# RUN rails g react:install
# RUN rails g rspec:install
# RUN rails g react:component HelloWorld name:string
# add react component HelloWorld to app/views/pages/index.html.erb

# RUN bundle install
# # once up with docker-compose so have db service
# --- manually add username, password, and host to config/database.yml
# --- specifically, postgres, postgres, db
# rake db:create

# add root 'pages#index' to config/routes.rb
# rails g controller pages index

# RUN bundle install --verbose --jobs 20 --retry 5

EXPOSE 2999

# CMD ["bundle","exec","rails","server",
#                "-p","2999","-b","0.0.0.0"]

CMD ["bash"]

# you always want to do this so you can do
# stuff before starting the server.
# so we just run bash and let you run
# the server with rails s -p 2999 -b 0.0.0.0
# after you have done any tasks

# This works for web container syncing to rubyabq.
# docker build .
# use docker network create my_net beforehand
#  docker run -v /Users/frankatjackrabbit/src/rubyabq:/rubyabq -it rubyabq_rubyabq --network my_net bash
#
