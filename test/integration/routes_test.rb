require 'test_helper'

#class RoutesTest < ActionController::IntegrationController
class RoutesTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  test "get /users/sign_out will call devise/sessions#destroy" do
  # Asserts that POSTing to /items will call the create action on ItemsController
    #assert_recognizes({controller: 'items', action: 'create'}, {path: 'items', method: :post})
    assert_recognizes( { controller: "devise/sessions", action: "destroy"}, { path: "users/sign_out", method: "get" } )
  end

end
