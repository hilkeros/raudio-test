require 'test_helper'

class SoundsControllerTest < ActionDispatch::IntegrationTest
  test "should get sine" do
    get sounds_sine_url
    assert_response :success
  end

  test "should get sampler" do
    get sounds_sampler_url
    assert_response :success
  end

end
