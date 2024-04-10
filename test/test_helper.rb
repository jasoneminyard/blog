# require simplecov to monitor code coverage
# xdg-open coverage/index.html to see results
require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def sign_up_and_login
    post "/users", params: { "user"=>{"email"=>"test_guy_1@yahoo.com", "username"=>"Test Guy One",
    "password"=>"123456", "password_confirmation"=>"123456", "commit"=>"Sign up" } }
  end
end
