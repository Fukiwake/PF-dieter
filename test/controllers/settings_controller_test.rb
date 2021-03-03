require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get setting" do
    get settings_setting_url
    assert_response :success
  end

end
