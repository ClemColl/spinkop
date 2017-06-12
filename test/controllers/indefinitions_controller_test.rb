require 'test_helper'

class IndefinitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @indefinition = indefinitions(:one)
  end

  test "should get index" do
    get indefinitions_url
    assert_response :success
  end

  test "should get new" do
    get new_indefinition_url
    assert_response :success
  end

  test "should create indefinition" do
    assert_difference('Indefinition.count') do
      post indefinitions_url, params: { indefinition: { auteur: @indefinition.auteur, description: @indefinition.description, name: @indefinition.name } }
    end

    assert_redirected_to indefinition_url(Indefinition.last)
  end

  test "should show indefinition" do
    get indefinition_url(@indefinition)
    assert_response :success
  end

  test "should get edit" do
    get edit_indefinition_url(@indefinition)
    assert_response :success
  end

  test "should update indefinition" do
    patch indefinition_url(@indefinition), params: { indefinition: { auteur: @indefinition.auteur, description: @indefinition.description, name: @indefinition.name } }
    assert_redirected_to indefinition_url(@indefinition)
  end

  test "should destroy indefinition" do
    assert_difference('Indefinition.count', -1) do
      delete indefinition_url(@indefinition)
    end

    assert_redirected_to indefinitions_url
  end
end
