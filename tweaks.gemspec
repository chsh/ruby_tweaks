# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tweaks}
  s.version = "0.0.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["CHIKURA Shinsaku"]
  s.date = %q{2010-12-19}
  s.description = %q{It basicly needs rails environment. But you can use some tweaks without rails.}
  s.email = %q{scene.sc@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/array_map_with_index_tweak.rb",
    "lib/array_refmap_tweak.rb",
    "lib/file_digest_tweak.rb",
    "lib/hash_from_json_tweak.rb",
    "lib/hash_pathable_tweak.rb",
    "lib/hash_remap_keys_tweak.rb",
    "lib/hash_with_default_tweak.rb",
    "lib/net_httpresponse_tweak.rb",
    "lib/object_class_config_tweak.rb",
    "lib/tweaks.rb",
    "test/files/root1/config/class_config.yml",
    "test/files/root1/config/class_configs/poo.yml",
    "test/files/root2/config/class_configs/poo2.yml",
    "test/files/root2/config/class_configs/poo3.yml",
    "test/files/root2/config/class_configs/poo4.yml",
    "test/helper.rb",
    "test/test_tweaks.rb"
  ]
  s.homepage = %q{http://gems.thinq.jp/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Tweaks is a pack of various utility methods.}
  s.test_files = [
    "test/helper.rb",
    "test/test_tweaks.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end

