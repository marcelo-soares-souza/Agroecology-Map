require 'test_helper'

class PlantasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planta = plantas(:one)
  end

  test "should get index" do
    get plantas_url
    assert_response :success
  end

  test "should get new" do
    get new_planta_url
    assert_response :success
  end

  test "should create planta" do
    assert_difference('Planta.count') do
      post plantas_url, params: { planta: { nome: @planta.nome, nome_cientifico: @planta.nome_cientifico, observacao: @planta.observacao, slug: @planta.slug, usuario_id: @planta.usuario_id } }
    end

    assert_redirected_to planta_url(Planta.last)
  end

  test "should show planta" do
    get planta_url(@planta)
    assert_response :success
  end

  test "should get edit" do
    get edit_planta_url(@planta)
    assert_response :success
  end

  test "should update planta" do
    patch planta_url(@planta), params: { planta: { nome: @planta.nome, nome_cientifico: @planta.nome_cientifico, observacao: @planta.observacao, slug: @planta.slug, usuario_id: @planta.usuario_id } }
    assert_redirected_to planta_url(@planta)
  end

  test "should destroy planta" do
    assert_difference('Planta.count', -1) do
      delete planta_url(@planta)
    end

    assert_redirected_to plantas_url
  end
end
