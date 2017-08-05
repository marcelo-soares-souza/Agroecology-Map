require 'test_helper'

class LocaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @local = locais(:one)
  end

  test "should get index" do
    get locais_url
    assert_response :success
  end

  test "should get new" do
    get new_local_url
    assert_response :success
  end

  test "should create local" do
    assert_difference('Local.count') do
      post locais_url, params: { local: { latitude: @local.latitude, longitude: @local.longitude, nome: @local.nome, observacao: @local.observacao, slug: @local.slug, usuario_id: @local.usuario_id } }
    end

    assert_redirected_to local_url(Local.last)
  end

  test "should show local" do
    get local_url(@local)
    assert_response :success
  end

  test "should get edit" do
    get edit_local_url(@local)
    assert_response :success
  end

  test "should update local" do
    patch local_url(@local), params: { local: { latitude: @local.latitude, longitude: @local.longitude, nome: @local.nome, observacao: @local.observacao, slug: @local.slug, usuario_id: @local.usuario_id } }
    assert_redirected_to local_url(@local)
  end

  test "should destroy local" do
    assert_difference('Local.count', -1) do
      delete local_url(@local)
    end

    assert_redirected_to locais_url
  end
end
