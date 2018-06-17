$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "turbolinks/rails/render/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "turbolinks-rails-render"
  s.version     = Turbolinks::Rails::Render::VERSION
  s.authors     = ["Jorge Manrubia"]
  s.email       = ["jorge.manrubia@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Turbolinks::Rails::Render."
  s.description = "TODO: Description of Turbolinks::Rails::Render."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
