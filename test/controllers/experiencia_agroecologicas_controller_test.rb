require 'test_helper'

class ExperienciaAgroecologicasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experiencia_agroecologica = experiencia_agroecologicas(:one)
  end

  test "should get index" do
    get experiencia_agroecologicas_url
    assert_response :success
  end

  test "should get new" do
    get new_experiencia_agroecologica_url
    assert_response :success
  end

  test "should create experiencia_agroecologica" do
    assert_difference('ExperienciaAgroecologica.count') do
      post experiencia_agroecologicas_url, params: { experiencia_agroecologica: { local_id: @experiencia_agroecologica.local_id, nome: @experiencia_agroecologica.nome, observacao: @experiencia_agroecologica.observacao, resumo: @experiencia_agroecologica.resumo, slug: @experiencia_agroecologica.slug, tema_experiencia_agroecologica_id: @experiencia_agroecologica.tema_experiencia_agroecologica_id, usuario_id: @experiencia_agroecologica.usuario_id } }
    end

    assert_redirected_to experiencia_agroecologica_url(ExperienciaAgroecologica.last)
  end

  test "should show experiencia_agroecologica" do
    get experiencia_agroecologica_url(@experiencia_agroecologica)
    assert_response :success
  end

  test "should get edit" do
    get edit_experiencia_agroecologica_url(@experiencia_agroecologica)
    assert_response :success
  end

  test "should update experiencia_agroecologica" do
    patch experiencia_agroecologica_url(@experiencia_agroecologica), params: { experiencia_agroecologica: { local_id: @experiencia_agroecologica.local_id, nome: @experiencia_agroecologica.nome, observacao: @experiencia_agroecologica.observacao, resumo: @experiencia_agroecologica.resumo, slug: @experiencia_agroecologica.slug, tema_experiencia_agroecologica_id: @experiencia_agroecologica.tema_experiencia_agroecologica_id, usuario_id: @experiencia_agroecologica.usuario_id } }
    assert_redirected_to experiencia_agroecologica_url(@experiencia_agroecologica)
  end

  test "should destroy experiencia_agroecologica" do
    assert_difference('ExperienciaAgroecologica.count', -1) do
      delete experiencia_agroecologica_url(@experiencia_agroecologica)
    end

    assert_redirected_to experiencia_agroecologicas_url
  end
end
