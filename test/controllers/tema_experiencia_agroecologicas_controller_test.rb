require 'test_helper'

class TemaExperienciaAgroecologicasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tema_experiencia_agroecologica = tema_experiencia_agroecologicas(:one)
  end

  test "should get index" do
    get tema_experiencia_agroecologicas_url
    assert_response :success
  end

  test "should get new" do
    get new_tema_experiencia_agroecologica_url
    assert_response :success
  end

  test "should create tema_experiencia_agroecologica" do
    assert_difference('TemaExperienciaAgroecologica.count') do
      post tema_experiencia_agroecologicas_url, params: { tema_experiencia_agroecologica: { nome: @tema_experiencia_agroecologica.nome, slug: @tema_experiencia_agroecologica.slug, usuario_id: @tema_experiencia_agroecologica.usuario_id } }
    end

    assert_redirected_to tema_experiencia_agroecologica_url(TemaExperienciaAgroecologica.last)
  end

  test "should show tema_experiencia_agroecologica" do
    get tema_experiencia_agroecologica_url(@tema_experiencia_agroecologica)
    assert_response :success
  end

  test "should get edit" do
    get edit_tema_experiencia_agroecologica_url(@tema_experiencia_agroecologica)
    assert_response :success
  end

  test "should update tema_experiencia_agroecologica" do
    patch tema_experiencia_agroecologica_url(@tema_experiencia_agroecologica), params: { tema_experiencia_agroecologica: { nome: @tema_experiencia_agroecologica.nome, slug: @tema_experiencia_agroecologica.slug, usuario_id: @tema_experiencia_agroecologica.usuario_id } }
    assert_redirected_to tema_experiencia_agroecologica_url(@tema_experiencia_agroecologica)
  end

  test "should destroy tema_experiencia_agroecologica" do
    assert_difference('TemaExperienciaAgroecologica.count', -1) do
      delete tema_experiencia_agroecologica_url(@tema_experiencia_agroecologica)
    end

    assert_redirected_to tema_experiencia_agroecologicas_url
  end
end
