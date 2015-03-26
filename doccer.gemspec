$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "doccer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "doccer"
  s.version     = Doccer::VERSION
  s.authors     = ["JoshAshby"]
  s.email       = ["joshuaashby@joshashby.com"]
  s.homepage    = "TODO"
  s.summary     = "API Documentation"
  s.description = "API Endpoint documentation designed to be lightweight and simple. If it gets in your way then its doing something wrong."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "haml-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "redcarpet"
end
