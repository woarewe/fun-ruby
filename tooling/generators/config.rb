# frozen_string_literal: true

module Tooling
  module Generators
    class Config
      SOURCE_DIR = File.expand_path('../../lib/fun_ruby', __dir__)
      MODULES_DIR = File.expand_path('./modules', SOURCE_DIR)
      MODULES_FILE = File.expand_path('./modules.rb', SOURCE_DIR)
    end
  end
end
