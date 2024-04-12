require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  #create
  
  test "signed in users can #create comments" do
    user = users(:admin)
    #article = articles(:one)
    
    article = Article.new title: "test one", 
                          body: "Now is the time for all good men to come to the aid of their country.", 
                          status: 'public', 
                          author: "Billy Bob",
                          user: user
    assert article.save
    assert sign_in(user)
    get articles_path
    get article_path(article)
    assert_difference(article.comments.count.to_s) do
      post article_comments_path(article), params: { comment:
                                  { commenter: "Joe Blow",
                                    body: "This article is interesting!",
                                    status: "public",
                                    user_id: user.id
                                  } }
    end

    #assert_redirected_to article_comments_path(article)
    #assert_equal "Comment was successfully created.", flash[:notice]
  end
end
