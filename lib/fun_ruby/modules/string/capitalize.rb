# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module String
      # Capitalizes the first letter of a string
      #
      # @since 0.1.0
      #
      # @param string [::String]
      #
      # @return [::String]
      #
      # @example Basics
      #   F::Modules::String.capitalize("hello") #=> "Hello"
      #
      # @example Curried
      #   curried = F::Modules::String.capitalize
      #   curried.("hello") #=> "Hello"
      #
      # @example Curried with placeholder
      #   curried = F::Modules::String.capitalize(F._)
      #   curried.("hello") #=> "Hello"
      def capitalize(string = F._)
        curry_implementation(:capitalize, string)
      end

      private

      def _capitalize(string)
        _string(string).capitalize
      end
    end
  end
end
