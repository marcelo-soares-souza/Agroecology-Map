require 'test_helper'

class OrganizacoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organizacao = organizacoes(:one)
  end

  test "should get index" do
    get organizacoes_url
    assert_response :success
  end

  test "should get new" do
    get new_organizacao_url
    assert_response :success
  end

  test "should create organizacao" do
    assert_difference('Organizacao.count') do
      post organizacoes_url, params: { organizacao: { cidade: @organizacao.cidade, descricao: @organizacao.descricao, email: @organizacao.email, latitude: @organizacao.latitude, longitude: @organizacao.longitude, nome: @organizacao.nome, observacao: @organizacao.observacao, pais: @organizacao.pais, sigla: @organizacao.sigla, site: @organizacao.site, slug: @organizacao.slug, telefone: @organizacao.telefone, tipo_organizacao_id: @organizacao.tipo_organizacao_id, uf: @organizacao.uf, usuario_id: @organizacao.usuario_id } }
    end

    assert_redirected_to organizacao_url(Organizacao.last)
  end

  test "should show organizacao" do
    get organizacao_url(@organizacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_organizacao_url(@organizacao)
    assert_response :success
  end

  test "should update organizacao" do
    patch organizacao_url(@organizacao), params: { organizacao: { cidade: @organizacao.cidade, descricao: @organizacao.descricao, email: @organizacao.email, latitude: @organizacao.latitude, longitude: @organizacao.longitude, nome: @organizacao.nome, observacao: @organizacao.observacao, pais: @organizacao.pais, sigla: @organizacao.sigla, site: @organizacao.site, slug: @organizacao.slug, telefone: @organizacao.telefone, tipo_organizacao_id: @organizacao.tipo_organizacao_id, uf: @organizacao.uf, usuario_id: @organizacao.usuario_id } }
    assert_redirected_to organizacao_url(@organizacao)
  end

  test "should destroy organizacao" do
    assert_difference('Organizacao.count', -1) do
      delete organizacao_url(@organizacao)
    end

    assert_redirected_to organizacoes_url
  end
end
