# frozen_string_literal: true

require_relative "lib/fun_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "fun-ruby"
  spec.version       = FunRuby::VERSION
  spec.authors       = ["woarewe"]
  spec.email         = ["rostislav.zhuravsky@gmail.com"]

  spec.summary       = "Write a short summary, because RubyGems requires one."
  spec.description   = "Write a longer description or delete this line."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|assets|bin|tooling)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
