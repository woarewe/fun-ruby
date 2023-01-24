# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns a string built from elements joined by a given string
      #
      # @since 0.1.0
      #
      # @param string [String]
      # @param array [::Array]
      #
      # @return [String]
      #
      # @example Basics
      #   ary = [1, 2, 3]
      #   F::Modules::Array.join("+", ary) # => "1+2+3"
      def join(string = F._, array = F._)
        curry_implementation(:join, string, array)
      end

      private

      def _join(string, array)
        _array(array).join(string)
      end
    end
  end
end
