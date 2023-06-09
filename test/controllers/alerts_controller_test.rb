require 'test_helper'

class AlertsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get alerts_create_url
    assert_response :success
  end

  test 'should get delete' do
    get alerts_delete_url
    assert_response :success
  end

  test 'should get index' do
    get alerts_index_url
    assert_response :success
  end
end
