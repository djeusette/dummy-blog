FROM ruby:2.2.3-slim

ENV HOME /home/rails/webapp

# Install dependencies
RUN apt-get -y update && apt-get install -y build-essential

WORKDIR $HOME

# Install gems
# Doing this before adding the code allows to benefit from the cache system
ADD Gemfile* $HOME/
RUN bundle install

# Add the app code
ADD . $HOME

EXPOSE 3000

# Default command
CMD ["rails", "server", "--binding", "0.0.0.0"]
