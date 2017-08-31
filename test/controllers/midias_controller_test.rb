require 'test_helper'

class MidiasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @midia = midias(:one)
  end

  test "should get index" do
    get midias_url
    assert_response :success
  end

  test "should get new" do
    get new_midia_url
    assert_response :success
  end

  test "should create midia" do
    assert_difference('Midia.count') do
      post midias_url, params: { midia: { descricao: @midia.descricao, experiencia_agroecologica_id: @midia.experiencia_agroecologica_id, saf_id: @midia.saf_id, slug: @midia.slug } }
    end

    assert_redirected_to midia_url(Midia.last)
  end

  test "should show midia" do
    get midia_url(@midia)
    assert_response :success
  end

  test "should get edit" do
    get edit_midia_url(@midia)
    assert_response :success
  end

  test "should update midia" do
    patch midia_url(@midia), params: { midia: { descricao: @midia.descricao, experiencia_agroecologica_id: @midia.experiencia_agroecologica_id, saf_id: @midia.saf_id, slug: @midia.slug } }
    assert_redirected_to midia_url(@midia)
  end

  test "should destroy midia" do
    assert_difference('Midia.count', -1) do
      delete midia_url(@midia)
    end

    assert_redirected_to midias_url
  end
end
