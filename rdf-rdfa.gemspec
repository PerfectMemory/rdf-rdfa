# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rdf-rdfa}
  s.version = "0.3.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gregg Kellogg"]
  s.date = %q{2011-07-11}
  s.description = %q{    RDF::RDFa is an RDFa reader/writer for Ruby using the RDF.rb library suite.
}
  s.email = %q{gregg@kellogg-assoc.com}
  s.extra_rdoc_files = [
    "AUTHORS",
    "CONTRIBUTORS",
    "History.md",
    "README.md"
  ]
  s.files = [
    ".yardopts",
    "AUTHORS",
    "CONTRIBUTORS",
    "Gemfile",
    "History.md",
    "README",
    "README.md",
    "Rakefile",
    "UNLICENSE",
    "VERSION",
    "etc/basic.html",
    "etc/foaf.html",
    "etc/profile.html",
    "etc/xhv.html",
    "example-files/bb-test.rb",
    "example-files/best-buy.html",
    "example-files/data-view.xhtml",
    "example-files/erdf_profile.html",
    "example-files/gk-foaf.html",
    "example-files/payswarm.html",
    "example-files/payswarm.n3",
    "example.rb",
    "lib/rdf/.gitignore",
    "lib/rdf/rdfa.rb",
    "lib/rdf/rdfa/format.rb",
    "lib/rdf/rdfa/patches/graph_properties.rb",
    "lib/rdf/rdfa/patches/literal_hacks.rb",
    "lib/rdf/rdfa/patches/nokogiri_hacks.rb",
    "lib/rdf/rdfa/patches/string_hacks.rb",
    "lib/rdf/rdfa/profile.rb",
    "lib/rdf/rdfa/profile/xhtml.rb",
    "lib/rdf/rdfa/profile/xml.rb",
    "lib/rdf/rdfa/reader.rb",
    "lib/rdf/rdfa/version.rb",
    "lib/rdf/rdfa/vocab.rb",
    "lib/rdf/rdfa/writer.rb",
    "lib/rdf/rdfa/writer/haml_templates.rb",
    "pkg/.gitignore",
    "rdf-rdfa.gemspec",
    "script/console",
    "script/intern_vocabulary",
    "script/parse",
    "script/tc",
    "script/yard-to-rubyforge",
    "spec/.gitignore",
    "spec/literal_spec.rb",
    "spec/matchers.rb",
    "spec/profile_spec.rb",
    "spec/reader_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/test_helper.rb",
    "spec/writer_spec.rb"
  ]
  s.homepage = %q{http://github.com/gkellogg/rdf-rdfa}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{RDFa reader/writer for RDF.rb.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, ["= 2.2.4"])
      s.add_runtime_dependency(%q<rdf>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.3"])
      s.add_runtime_dependency(%q<facets>, [">= 2.9.1"])
      s.add_development_dependency(%q<open-uri-cached>, [">= 0.0.3"])
      s.add_development_dependency(%q<rdf-spec>, [">= 0"])
      s.add_development_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
      s.add_development_dependency(%q<rdf-n3>, [">= 0.3.1"])
      s.add_development_dependency(%q<rspec>, [">= 2.1.0"])
      s.add_development_dependency(%q<sxp>, [">= 0"])
      s.add_development_dependency(%q<sparql-algebra>, [">= 0"])
      s.add_development_dependency(%q<sparql-grammar>, [">= 0"])
      s.add_development_dependency(%q<spira>, [">= 0.0.12"])
      s.add_development_dependency(%q<yard>, [">= 0.6.4"])
      s.add_runtime_dependency(%q<rdf>, [">= 0.3.3"])
      s.add_runtime_dependency(%q<haml>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_runtime_dependency(%q<facets>, [">= 2.9.1"])
      s.add_development_dependency(%q<spira>, [">= 0.0.12"])
      s.add_development_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_development_dependency(%q<rdf-spec>, [">= 0.3.3"])
      s.add_development_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<addressable>, ["= 2.2.4"])
      s.add_dependency(%q<rdf>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 3.0.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.3.3"])
      s.add_dependency(%q<facets>, [">= 2.9.1"])
      s.add_dependency(%q<open-uri-cached>, [">= 0.0.3"])
      s.add_dependency(%q<rdf-spec>, [">= 0"])
      s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
      s.add_dependency(%q<rdf-n3>, [">= 0.3.1"])
      s.add_dependency(%q<rspec>, [">= 2.1.0"])
      s.add_dependency(%q<sxp>, [">= 0"])
      s.add_dependency(%q<sparql-algebra>, [">= 0"])
      s.add_dependency(%q<sparql-grammar>, [">= 0"])
      s.add_dependency(%q<spira>, [">= 0.0.12"])
      s.add_dependency(%q<yard>, [">= 0.6.4"])
      s.add_dependency(%q<rdf>, [">= 0.3.3"])
      s.add_dependency(%q<haml>, [">= 3.0.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_dependency(%q<facets>, [">= 2.9.1"])
      s.add_dependency(%q<spira>, [">= 0.0.12"])
      s.add_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_dependency(%q<rdf-spec>, [">= 0.3.3"])
      s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<addressable>, ["= 2.2.4"])
    s.add_dependency(%q<rdf>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 3.0.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.3.3"])
    s.add_dependency(%q<facets>, [">= 2.9.1"])
    s.add_dependency(%q<open-uri-cached>, [">= 0.0.3"])
    s.add_dependency(%q<rdf-spec>, [">= 0"])
    s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
    s.add_dependency(%q<rdf-n3>, [">= 0.3.1"])
    s.add_dependency(%q<rspec>, [">= 2.1.0"])
    s.add_dependency(%q<sxp>, [">= 0"])
    s.add_dependency(%q<sparql-algebra>, [">= 0"])
    s.add_dependency(%q<sparql-grammar>, [">= 0"])
    s.add_dependency(%q<spira>, [">= 0.0.12"])
    s.add_dependency(%q<yard>, [">= 0.6.4"])
    s.add_dependency(%q<rdf>, [">= 0.3.3"])
    s.add_dependency(%q<haml>, [">= 3.0.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
    s.add_dependency(%q<facets>, [">= 2.9.1"])
    s.add_dependency(%q<spira>, [">= 0.0.12"])
    s.add_dependency(%q<rspec>, [">= 2.5.0"])
    s.add_dependency(%q<rdf-spec>, [">= 0.3.3"])
    s.add_dependency(%q<rdf-isomorphic>, [">= 0.3.4"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

