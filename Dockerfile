# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install
RUN rails db:migrate

# Copy the application code to the container
COPY . .

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
