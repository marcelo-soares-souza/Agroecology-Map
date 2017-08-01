CONFIG = YAML.load_file("#{Rails.root}/config/mapadaagroecologia.yml")

Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"
Date::DATE_FORMATS[:default] = "%d/%m/%Y"
