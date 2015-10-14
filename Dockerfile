FROM ruby:2.2.3

ENV HOME /home/app

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

WORKDIR $HOME

# Install gems
# Doing this before adding the code allows to benefit from the cache system
ADD Gemfile* $HOME/
RUN bundle check || bundle install --jobs=4 --retry=3

# Add the app code
ADD . $HOME

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

# Default command
CMD ["rails", "server", "--binding", "0.0.0.0"]
