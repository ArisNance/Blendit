require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get unsplash" do
    get :unsplash
    assert_response :success
  end

end
