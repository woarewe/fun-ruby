# frozen_string_literal: true

module FunRuby
  module Curried
    class Function
      def initialize(name:, owner:, arguments:, types:, state:)
        @name = name
        @owner = owner
        @arguments = arguments
        @types = types
        @state = state
      end
    end
  end
end
