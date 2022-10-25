# config/initializers/field_with_error.rb

# Corrige a Alteração do Layout do Formulário em caso de Erro na Submissão

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_attr_index = html_tag.index 'class="'

  if class_attr_index
    html_tag.insert class_attr_index + 7, 'error '
  else
    html_tag.insert html_tag.index('>'), ' class="error"'
  end
end
