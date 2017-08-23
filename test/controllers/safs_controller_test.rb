require 'test_helper'

class SafsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saf = safs(:one)
  end

  test "should get index" do
    get safs_url
    assert_response :success
  end

  test "should get new" do
    get new_saf_url
    assert_response :success
  end

  test "should create saf" do
    assert_difference('Saf.count') do
      post safs_url, params: { saf: { area: @saf.area, fim: @saf.fim, inicio: @saf.inicio, local_id: @saf.local_id, nome: @saf.nome, objetivo: @saf.objetivo, observacao: @saf.observacao, produto_principal: @saf.produto_principal, slug: @saf.slug, usuario_id: @saf.usuario_id } }
    end

    assert_redirected_to saf_url(Saf.last)
  end

  test "should show saf" do
    get saf_url(@saf)
    assert_response :success
  end

  test "should get edit" do
    get edit_saf_url(@saf)
    assert_response :success
  end

  test "should update saf" do
    patch saf_url(@saf), params: { saf: { area: @saf.area, fim: @saf.fim, inicio: @saf.inicio, local_id: @saf.local_id, nome: @saf.nome, objetivo: @saf.objetivo, observacao: @saf.observacao, produto_principal: @saf.produto_principal, slug: @saf.slug, usuario_id: @saf.usuario_id } }
    assert_redirected_to saf_url(@saf)
  end

  test "should destroy saf" do
    assert_difference('Saf.count', -1) do
      delete saf_url(@saf)
    end

    assert_redirected_to safs_url
  end
end
