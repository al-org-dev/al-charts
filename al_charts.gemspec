Gem::Specification.new do |spec|
  spec.name          = "al_charts"
  spec.version       = "1.0.0"
  spec.authors       = ["al-org"]
  spec.email         = ["dev@al-org.dev"]
  spec.summary       = "Chart and diagram asset pipeline for al-folio Jekyll sites"
  spec.description   = "Jekyll plugin extracted from al-folio that ships chart assets and conditionally renders Mermaid, ECharts, Plotly, Vega-Lite, Leaflet, and diff2html scripts."
  spec.homepage      = "https://github.com/al-org-dev/al-charts"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage
  }

  spec.files         = Dir["lib/**/*", "LICENSE", "README.md", "CHANGELOG.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.9", "< 5.0"
  spec.add_dependency "liquid", ">= 4.0", "< 6.0"

  spec.add_development_dependency "bundler", ">= 2.0", "< 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
