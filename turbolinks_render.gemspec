$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'turbolinks_render/version'

rails_version = ENV['RAILS_VERSION'] || '5.2.0'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'turbolinks_render'
  s.version     = TurbolinksRender::VERSION
  s.authors     = ['Jorge Manrubia']
  s.email       = ['jorge.manrubia@gmail.com']
  s.homepage    = 'https://github.com/jorgemanrubia/turbolinks_render'
  s.summary     = 'Use Rails render with Turbolinks'
  s.description = 'Use render in your Rails controllers and handle the response with Turbolinks.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', ">= #{rails_version}"
  s.add_dependency 'turbolinks-source', '~> 5.1'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'turbolinks'
  s.add_development_dependency 'webdrivers'
end
