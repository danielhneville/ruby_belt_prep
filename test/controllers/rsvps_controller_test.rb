require 'test_helper'

class RsvpsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get rsvps_create_url
    assert_response :success
  end

  test "should get destroy" do
    get rsvps_destroy_url
    assert_response :success
  end

end
