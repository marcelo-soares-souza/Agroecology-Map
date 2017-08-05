require 'test_helper'

class TipoOrganizacoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_organizacao = tipo_organizacoes(:one)
  end

  test "should get index" do
    get tipo_organizacoes_url
    assert_response :success
  end

  test "should get new" do
    get new_tipo_organizacao_url
    assert_response :success
  end

  test "should create tipo_organizacao" do
    assert_difference('TipoOrganizacao.count') do
      post tipo_organizacoes_url, params: { tipo_organizacao: { nome: @tipo_organizacao.nome, slug: @tipo_organizacao.slug, usuario_id: @tipo_organizacao.usuario_id } }
    end

    assert_redirected_to tipo_organizacao_url(TipoOrganizacao.last)
  end

  test "should show tipo_organizacao" do
    get tipo_organizacao_url(@tipo_organizacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipo_organizacao_url(@tipo_organizacao)
    assert_response :success
  end

  test "should update tipo_organizacao" do
    patch tipo_organizacao_url(@tipo_organizacao), params: { tipo_organizacao: { nome: @tipo_organizacao.nome, slug: @tipo_organizacao.slug, usuario_id: @tipo_organizacao.usuario_id } }
    assert_redirected_to tipo_organizacao_url(@tipo_organizacao)
  end

  test "should destroy tipo_organizacao" do
    assert_difference('TipoOrganizacao.count', -1) do
      delete tipo_organizacao_url(@tipo_organizacao)
    end

    assert_redirected_to tipo_organizacoes_url
  end
end
