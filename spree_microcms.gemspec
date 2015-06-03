$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_microcms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_microcms"
  s.version     = SpreeMicrocms::VERSION
  s.authors     = ["Diego Steiner"]
  s.email       = ["diego.steiner@renuo.ch"]
  s.homepage    = "https://renuo.ch/spree"
  s.summary     = "This is a very minimalistic CMS"
  s.description = "With this plugin you can create CMS pages in the Spree admin panel"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'spree_core', '~> 3.0'
  s.add_dependency "ckeditor", '~> 4.0'
  s.add_dependency "ancestry"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rubocop"
end
