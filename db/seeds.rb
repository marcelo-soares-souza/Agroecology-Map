usuario = Usuario.new(nome: "Administrador", email: "admin@agroecologia", password: "agroecologia", password_confirmation: "agroecologia", admin: "t").save(validate: false)
tipo_organizacao = TipoOrganizacao.new(nome: "ONG").save(validate: false)

