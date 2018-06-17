$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "turbolinks/rails_render/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "turbolinks-rails-render"
  s.version     = Turbolinks::Rails::Render::VERSION
  s.authors     = ["Jorge Manrubia"]
  s.email       = ["jorge.manrubia@gmail.com"]
  s.homepage    = "https://github.com/jorgemanrubia/turbolinks-rails-render"
  s.summary     = "Use Rails render with Turbolinks"
  s.description = "Use Rails render with Turbolinks"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "turbolinks", "~> 5.1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara"
  s.add_development_dependency "chromedriver-helper"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "puma"
  s.add_development_dependency "turbolinks"
end
