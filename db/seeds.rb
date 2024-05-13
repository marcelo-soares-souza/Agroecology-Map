# frozen_string_literal: true

email = ENV.fetch("ADMIN_EMAIL") { "admin@agroecologymap.org" }
password = ENV.fetch("ADMIN_PASSWORD") { "agroecology" }

account_admin = Account.new(name: "Agroecology Map Administrator", email:, password:, admin: "t")
account_admin.password_confirmation = password
account_admin.skip_confirmation!
account_admin.save!

account_agroecologia = Account.new(name: "Agroecology Map", email: "contact@agroecologymap.org", password:, admin: "f")
account_agroecologia.password_confirmation = password
account_agroecologia.skip_confirmation!
account_agroecologia.save!
