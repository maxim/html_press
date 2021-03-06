# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{html_press}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maxim Chernyak"]
  s.date = %q{2009-10-20}
  s.default_executable = %q{hpress}
  s.description = %q{This middleware aims to compress the crap out of your HTML on-the-fly. It squeezes out every last kilobyte of traffic for your users. In some cases it can save ~50kb per request which may amount to 5 seconds of wait for a dial up user somewhere in the world. To prevent re-compressing on every request it uses checksum-based caching mechnism easily swappable for any key-value store. Among unique awesome features HTMLPress is smart enough to ignore rails authenticity tokens when it caches HTML. This avoids constant re-compressing on form pages.}
  s.email = %q{max@bitsonnet.com}
  s.executables = ["hpress"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/hpress",
     "html_press.gemspec",
     "init.rb",
     "lib/html_press.rb",
     "lib/html_press/html_press.rb",
     "lib/html_press/html_press.rb",
     "lib/html_press/identity_parser.rb",
     "lib/html_press/identity_parser.rb",
     "lib/html_press/rack.rb",
     "lib/html_press/rack.rb",
     "lib/html_press/runner.rb",
     "lib/html_press/runner.rb",
     "lib/html_press/store.rb",
     "lib/html_press/store.rb",
     "tasks/hpress.rake",
     "test/helper.rb",
     "test/test_html_press.rb"
  ]
  s.homepage = %q{http://github.com/maxim/html_press}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{API and Rack middleware for HTML compression with caching support.}
  s.test_files = [
    "test/helper.rb",
     "test/test_html_press.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.8"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.8"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end

