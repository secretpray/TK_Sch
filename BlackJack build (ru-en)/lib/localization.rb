module Localization
  extend self
  
  def init!(locale = :en)
    @translations = YAML.load_file("lib/locales/#{locale}.yml")
  end

  def translate(key)
    @translations[key.to_s]
  end
end
