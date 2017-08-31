require 'test_helper'

class AnimaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal = animais(:one)
  end

  test "should get index" do
    get animais_url
    assert_response :success
  end

  test "should get new" do
    get new_animal_url
    assert_response :success
  end

  test "should create animal" do
    assert_difference('Animal.count') do
      post animais_url, params: { animal: { nome: @animal.nome, nome_cientifico: @animal.nome_cientifico, observacao: @animal.observacao, slug: @animal.slug, usuario_id: @animal.usuario_id } }
    end

    assert_redirected_to animal_url(Animal.last)
  end

  test "should show animal" do
    get animal_url(@animal)
    assert_response :success
  end

  test "should get edit" do
    get edit_animal_url(@animal)
    assert_response :success
  end

  test "should update animal" do
    patch animal_url(@animal), params: { animal: { nome: @animal.nome, nome_cientifico: @animal.nome_cientifico, observacao: @animal.observacao, slug: @animal.slug, usuario_id: @animal.usuario_id } }
    assert_redirected_to animal_url(@animal)
  end

  test "should destroy animal" do
    assert_difference('Animal.count', -1) do
      delete animal_url(@animal)
    end

    assert_redirected_to animais_url
  end
end
