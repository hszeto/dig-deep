
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dig_deep/version"

Gem::Specification.new do |spec|
  spec.name          = "dig-deep"
  spec.version       = DigDeep::VERSION
  spec.authors       = ["Henry Szeto"]
  spec.email         = ["henryszeto@gmail.com"]

  spec.summary       = %q{Dig into a nested Hash and return all values by the key.}
  spec.description   = %q{Give a hash key, DigDeep will recursively search in the hash and return all values.}
  spec.homepage      = "https://github.com/hszeto/dig-deep"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
