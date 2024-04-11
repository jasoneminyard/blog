require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
  end

  test "index if @count == 1" do
    get articles_url
    assert_response :success
    Article.destroy_all #i need one Article to go down the correct path so destroy all
    assert Article.count == 0
    article = Article.new title: "test one", 
                          body: "Now is the time for all good men to come to the aid of their country.", 
                          status: 'public', 
                          author: "Billy Bob",
                          user: users(:admin)
    assert article.save
    get '/articles'
    assert_response :success
    assert_equal "index", @controller.action_name
    assert_match "article", @response.body
  end

  test "#show should show article" do
    article = articles(:one)
    get article_url(article)
    assert_response :success
  end

  test "#new should redirect when not signed in" do
    get new_article_url
    assert_response :redirect
  end
  
  test "#new should show form when user signed in" do
    get "/users/sign_up"
    assert_response :success

    post "/users", params: { "user"=>{"email"=>"test_guy_1@yahoo.com", "username"=>"Test Guy One",
        "password"=>"123456", "password_confirmation"=>"123456", "commit"=>"Sign up" } }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert User.last.username == "Test Guy One" 

    get new_article_url
    assert_response :success
    assert_match "New Article", @response.body
  end

  test "#create should create article" do
    sign_in(users(:admin))
    assert_difference("Article.count") do
      post articles_url, params: { article: 
                                          { title: "Some title", 
                                            body: "one, two, three, four, five, six, seven, eight, nine", 
                                            status: "public",
                                            author: "junior",
                                            user_id: users(:admin).id } }
    end
    
    assert_redirected_to article_path(Article.last)
    assert_equal "Article was successfully created.", flash[:notice]
  end

  test "should update article" do
    article = articles(:one)
    sign_in(users(:admin))
    patch article_url(article), params: { article: { title: "updated" } }
    assert_redirected_to article_path(article)
    # Reload association to fetch updated data and assert that title is updated.
    article.reload
    assert_equal "updated", article.title
  end
  
  test "should destroy article" do
    article = articles(:one)
    sign_in(users(:admin))
    assert_difference("Article.count", -1) do
      delete article_url(article)
    end
  
    assert_redirected_to root_path
  end
  
end
