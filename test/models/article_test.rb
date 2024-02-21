require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save article without required attributes" do
    article = Article.new
    assert_not article.save, "saved article without required attributes"
    assert_not article.update(title: "test_one"), "saved article without required attributes"
    assert_not article.update(body: "123456789"), "saved article without required attributes"

    assert article.update(body: "1234567890", status: "public"), "failed to save article with required attributes"
  end
end
