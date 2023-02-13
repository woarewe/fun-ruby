# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module String
      # Calculates the size of a string
      #
      # @since 0.1.0
      #
      # @param string [::String]
      #
      # @return [::Integer]
      #
      # @example Basics
      #   F::Modules::String.size("hello") #=> 5
      #
      # @example Curried
      #   curried = F::Modules::String.size
      #   curried.("hello") #=> 5
      #
      # @example Curried with placeholder
      #   curried = F::Modules::String.size(F._)
      #   curried.("hello") #=> 5
      def size(string = F._)
        curry_implementation(:size, string)
      end

      private

      def _size(string)
        _string(string).size
      end
    end
  end
end
