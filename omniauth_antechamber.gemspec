$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth_antechamber/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "omniauth-antechamber"
  s.version     = OmniauthAntechamber::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["@warwickshire.gov.uk"]
  s.homepage    = "https://github.com/warwickshire/omniauth_antechamber"
  s.summary     = "Omniauth strategy for Antechamber"
  s.description = "Antechamber is an authentication gateway. This gem provides a client application with the omniauth strategy to connect to Antechamber"
  s.license     = "MIT-LICENSE"
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "omniauth"
  s.add_dependency "omniauth-oauth2"

end
