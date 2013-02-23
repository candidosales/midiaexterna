require 'test_helper'

class ParceirosControllerTest < ActionController::TestCase
  setup do
    @parceiro = parceiros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parceiros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parceiro" do
    assert_difference('Parceiro.count') do
      post :create, parceiro: { bairro: @parceiro.bairro, cep: @parceiro.cep, cidade: @parceiro.cidade, cpnj: @parceiro.cpnj, email: @parceiro.email, endereco: @parceiro.endereco, estado: @parceiro.estado, nome: @parceiro.nome, tel: @parceiro.tel }
    end

    assert_redirected_to parceiro_path(assigns(:parceiro))
  end

  test "should show parceiro" do
    get :show, id: @parceiro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parceiro
    assert_response :success
  end

  test "should update parceiro" do
    put :update, id: @parceiro, parceiro: { bairro: @parceiro.bairro, cep: @parceiro.cep, cidade: @parceiro.cidade, cpnj: @parceiro.cpnj, email: @parceiro.email, endereco: @parceiro.endereco, estado: @parceiro.estado, nome: @parceiro.nome, tel: @parceiro.tel }
    assert_redirected_to parceiro_path(assigns(:parceiro))
  end

  test "should destroy parceiro" do
    assert_difference('Parceiro.count', -1) do
      delete :destroy, id: @parceiro
    end

    assert_redirected_to parceiros_path
  end
end
