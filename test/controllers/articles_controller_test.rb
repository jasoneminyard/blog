require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "index if @count == 1" do
    get articles_url
    assert_response :success
    Article.last.destroy #i need only one Article to go down the correct path
    assert Article.count == 1
    article = Article.new title: "test one", body: "Now is the time for all good men to come to the aid of their country.", status: 'public', author: "Billy Bob"
    assert article.save
    get '/articles'
    assert_response :success
    assert_equal "index", @controller.action_name
    assert_match "article", @response.body
  end

  test "#show article"
    
  end
end
