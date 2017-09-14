usuario_admin = Usuario.new(nome: "Administrador", email: "admin@agroecologia", password: "agroecologia", password_confirmation: "agroecologia", admin: "t")
#usuario_admin.skip_confirmation!
usuario_admin.save!

usuario_itbio3 = Usuario.new(nome: "ITBio3", email: "contact@itbio3.org", password: "itbio3", password_confirmation: "itbio3", admin: "f")
#usuario_itbio3.skip_confirmation!
usuario_itbio3.save!

TipoOrganizacao.new(nome: "Organização Não Governamental", usuario_id: 1).save!
TipoOrganizacao.new(nome: "Governamental", usuario_id: 1).save!
TipoOrganizacao.new(nome: "Privada", usuario_id: 1).save!

TemaExperienciaAgroecologica.new(nome: "Agricultura Urbana", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Alimentação", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Saúde e plantas medicinais", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Desenvolvimento Rural", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Desenvolvimento Local", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Educação", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Pesquisa Agrícola e Extensão Rural", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Manejo de Recursos Hídricos", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Certificação", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Comercialização", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Processamento e beneficiamento da produção", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Sementes", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Sistemas Agroflorestais", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Manejo da vegetação nativa e agroextrativismo", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Sistemas de criação animal", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Sistema de Produção Agrícola", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Correntes de Agricultura Alternativa", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Manejo de pragas, doenças e plantas espontâneas", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Manejo dos solos", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Acesso a terra, reforma agrária e Agroecologia", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Relação com os mercados", usuario_id: 1).save!
TemaExperienciaAgroecologica.new(nome: "Outros", usuario_id: 1).save!


