
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scrapeddit/version"

Gem::Specification.new do |spec|
  spec.name          = "scrapeddit"
  spec.version       = Scrapeddit::VERSION
  spec.authors       = ["Jordan Kline"]
  spec.email         = "jordan.kline@gmail.com"

  spec.summary       = %q{A simple Reddit scraper}
  spec.description   = %q{A simple Reddit front page scraper}
  spec.homepage      = "https://github.com/jordaninthewind/scrapeddit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = "scrapeddit"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "colorize", ">= 0"
end
