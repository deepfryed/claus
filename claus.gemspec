# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "claus"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bharanee Rathna"]
  s.date = "2012-05-18"
  s.description = "simple hash / array based rule matching engine"
  s.email = ["deepfryed@gmail.com"]
  s.files = ["test/helper.rb", "test/test_claus.rb", "lib/claus.rb", "README.md"]
  s.homepage = "http://github.com/deepfryed/claus"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "simple hash / array based rule expression"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
