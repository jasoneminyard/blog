require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end


  #was the web request successful?
  #was the user redirected to the right page?
  #was the user successfully authenticated?
  #was the appropriate message displayed to the user in the view?
  #was the correct information displayed in the response?

  #create
  
  test "signed in users can #create comments" do
    user = users(:one)
    article = articles(:one)
    assert sign_in(user)

    assert_difference("Comment.count") do
      post article_comments_path(article), params: { 
        comment:
          { commenter: user.username,
            body: "This article is interesting!",
            status: "public",
            user_id: user.id
          } }
    end
    
    assert_response :found
    assert_redirected_to article_path(article)
    assert_equal "Comment was successfully created.", flash[:notice]
  end

  #destroy

  test "signed in users can #destory their comments" do
    user = users(:one)
    article = articles(:one)
    assert sign_in(user)

    assert_difference("Comment.count") do
      post article_comments_path(article), params: { 
        comment:
          { commenter: user.username,
            body: "This article is interesting!",
            status: "public",
            user_id: user.id
          } }
    end
    
    assert_response :found
    assert_redirected_to article_path(article)
    assert_equal "Comment was successfully created.", flash[:notice]

    assert_difference("Comment.count", -1) do
      delete article_comment_path(article, Comment.last)
    end
  end

end
