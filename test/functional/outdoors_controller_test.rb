require 'test_helper'

class OutdoorsControllerTest < ActionController::TestCase
  setup do
    @outdoor = outdoors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outdoors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outdoor" do
    assert_difference('Outdoor.count') do
      post :create, outdoor: { bairro: @outdoor.bairro, cidade: @outdoor.cidade, endereco: @outdoor.endereco, numero: @outdoor.numero, posicao: @outdoor.posicao }
    end

    assert_redirected_to outdoor_path(assigns(:outdoor))
  end

  test "should show outdoor" do
    get :show, id: @outdoor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outdoor
    assert_response :success
  end

  test "should update outdoor" do
    put :update, id: @outdoor, outdoor: { bairro: @outdoor.bairro, cidade: @outdoor.cidade, endereco: @outdoor.endereco, numero: @outdoor.numero, posicao: @outdoor.posicao }
    assert_redirected_to outdoor_path(assigns(:outdoor))
  end

  test "should destroy outdoor" do
    assert_difference('Outdoor.count', -1) do
      delete :destroy, id: @outdoor
    end

    assert_redirected_to outdoors_path
  end
end
