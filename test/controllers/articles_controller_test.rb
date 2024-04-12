require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # called after every single test
  teardown do
    # when controller is using cache it may be a good idea to reset it afterwards
    Rails.cache.clear
  end

  #index

  test "admin can access index" do
    sign_in(users(:admin))
    get articles_url
    assert_response :success
  end

  test "non-admin can access index" do
    sign_in(users(:one))
    get articles_url
    assert_response :success
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

  #show

  test "#admin can access show article" do
    sign_in(users(:admin))
    article = articles(:one)
    get article_url(article)
    assert_response :success
  end
  
  test "non-admin can view public article" do
    article = articles(:one)
    get article_url(article)
    assert_response :success
  end

  test "non-admin can NOT view non-public articles" do
    sign_in(users(:one))
    assert_raises("AccessDenied") do
      get article_url(articles(:private))
    end

    assert_raises("AccessDenied") do
      get article_url(articles(:archived))
    end
  end

  #new

  test "admin can view new form when logged in" do
    sign_in(users(:admin))
    get new_article_url
    assert_response :success
    assert_match "New Article", @response.body
  end

  test "no one can access new form when NOT logged in" do
    get new_article_url
    assert_response :redirect
  end

  test "non-admin can NOT access new form when signed in" do
    sign_in(users(:one))
    assert_raises("AccessDenied") do
      get new_article_url
    end
  end

  #create

  test "admin can create article" do
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

  test "non-admin can NOT create article" do
    sign_in(users(:one))
    assert_raises("AccessDenied") do
      post articles_url, params: { article: 
                                          { title: "Some title", 
                                            body: "one, two, three, four, five, six, seven, eight, nine", 
                                            status: "public",
                                            author: "junior",
                                            user_id: users(:one).id } }
    end 
  end

  #update

  test "admin can update article" do
    article = articles(:one)
    sign_in(users(:admin))
    patch article_url(article), params: { article: { title: "updated" } }
    assert_redirected_to article_path(article)
    # Reload association to fetch updated data and assert that title is updated.
    article.reload
    assert_equal "updated", article.title
  end

  test "non-admin can NOT update article" do
    sign_in(users(:one))
    assert_raises("AccessDenied") do
      patch article_url(article), params: { article: { title: "updated" } }
    end
  end
  
  #destroy

  test "admin can destroy article" do
    article = articles(:one)
    sign_in(users(:admin))
    assert_difference("Article.count", -1) do
      delete article_url(article)
    end
  
    assert_redirected_to root_path
  end

  test "non-admin can NOT destroy article" do
    article = articles(:one)
    sign_in(users(:one))
    assert_raises("AccessDenied") do
      delete article_url(article)
    end
  end
end
