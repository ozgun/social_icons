$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social_icons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social_icons"
  s.version     = SocialIcons::VERSION
  s.authors     = ["Özgün Koyun"]
  s.email       = ["kozgun@gmail.com"]
  s.homepage    = "https://github.com/ozgun/social_icons"
  s.summary     = "Add social buttons to your Rails app."
  s.description = "Twitter, Facebook, Google+."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
