require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "articles.count" do
    get articles_url
    assert_response :success
    puts "Article.count =" + Article.count.to_s
    assert Article.count == 0
    article = Article.new title: "test one", body: "Now is the time for all good men to come to the aid of their country."
    assert article.save
  end
end
