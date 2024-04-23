require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @article = articles :one
    sign_in users(:admin)
  end

  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Articles"
  end

  test "should create article" do
    visit articles_url
    click_on "New Article"
    fill_in "Title", with: "should create article"
    fill_in "Body", with: "Now is the time for all men to come to the aid of their country."
    click_on "Create Article"
    assert_text "Article was successfully created"
  end

  test "should update Article" do
    visit article_url @article
    click_on "Edit this article", match: :first
    click_on "Update Article"
    assert_text "Article was successfully updated."
    click_on "Articles"
  end

  test "should destroy Article" do
    visit article_url(@article)
    click_on "Delete this article!", match: :first
    accept_confirm
    assert_text "Article was successfully deleted."
  end
end
