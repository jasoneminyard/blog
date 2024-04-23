require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles :one
    sign_in users(:admin)
    visit article_url @article
  end

  test "should create comment" do
    fill_in "Body", with: "Now is the time for all men to come to the aid of their country."
    click_on "Create Comment"
    assert_text "Comment was successfully created."
  end

  test "should destroy Comment" do
    click_on "Delete Comment", match: :first
    accept_confirm
    assert_text "Comment was successfully deleted."
  end
end
