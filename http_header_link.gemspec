require_relative 'lib/http_header_link/version'

Gem::Specification.new do |spec|
  spec.name          = "http_header_link"
  spec.version       = HttpHeaderLink::VERSION
  spec.authors       = ["sainu"]
  spec.email         = ["katsutoshi.saino@gmail.com"]

  spec.summary       = %q{The library handling the Link header, written in Ruby.}
  spec.description   = %q{The library handling the Link header, written in Ruby.}
  spec.homepage      = "https://github.com/sainuio/http_header_link/"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sainuio/http_header_link/"
  spec.metadata["changelog_uri"] = "https://github.com/sainuio/http_header_link/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end