# frozen_string_literal: true

require_relative "common/helpers"

module FunRuby
  # Top level parent for all modules
  module Modules; end
end

require_relative "modules/array"
require_relative "modules/enum"
require_relative "modules/file"
require_relative "modules/function"
require_relative "modules/hash"
require_relative "modules/string"
