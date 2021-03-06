require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test 'should get categories index' do
    get :index
    assert_response :success
  end

  test 'should get categories new' do
    get :new
    assert_response :success
  end

  test 'should get categories show' do
    get(:show, 'id' => @category.id)
    assert_response :success
  end
end
