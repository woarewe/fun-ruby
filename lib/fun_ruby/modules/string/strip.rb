# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module String
      # Removes leading and trailing whitespaces from a string
      #
      # @since 0.1.0
      #
      # @param string [::String]
      #
      # @return [::String]
      #
      # @example Basics
      #   F::Modules::String.strip("  hello  ") #=> "hello"
      #   F::Modules::String.strip("\n\r  hello  \n") #=> "hello"
      #   F::Modules::String.strip("\n\r  hello  \n\r") #=> "hello"
      #
      # @example Curried
      #   curried = F::Modules::String.strip
      #   curried.("  hello  ") #=> "hello"
      #   curried.("\n\r  hello  \n\r") #=> "hello"
      #
      # @example Curried with placeholder
      #   curried = F::Modules::String.strip(F._)
      #   curried.("  hello  ") #=> "hello"
      #   curried.("\n\r  hello  \n\r") #=> "hello"
      def strip(string = F._)
        curry_implementation(:strip, string)
      end

      private

      def _strip(string)
        _string(string).strip
      end
    end
  end
end
