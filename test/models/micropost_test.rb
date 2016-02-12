require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @micropost = @user.microposts.build(content: "Lorem ipsum")
 end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test 'micropost has content' do
    @micropost.content = nil
    assert_not @micropost.valid?
  end

  test 'micropost lenght'do
    content = 'a' * 141
    @micropost.content = content
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
   assert_equal Micropost.first, microposts(:most_recent)
 end
end
