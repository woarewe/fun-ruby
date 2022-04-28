# frozen_string_literal: true

require_relative "common/helpers"

module FunRuby
  # Module containing methods for strings
  module String
    include Common::Helpers

    extend self

    # Split a string by a passed delimiter
    #
    # @since 0.1.0
    #
    # @param splitter [::Array|::Regexp]
    # @param string [::String]
    #
    # @return [::Array[::String]]
    #
    # @example Basics
    #   F::String.split("+", "1+2+3") #=> ["1", "2", "3"]
    #
    # @example Curried
    #   curried = F::String.split
    #   curried.("+").("1+2+3") #=> ["1", "2", "3"]
    #
    # @example Curried with placeholder
    #   curried = F::String.split(F._, "1+2+3")
    #   curried.("+") #=> ["1", "2", "3"]
    def split(splitter = F._, string = F._)
      curry_implementation(:split, splitter, string)
    end

    # Concats a string by a passed delimiter
    #
    # @since 0.1.0
    #
    # @param first [::String]
    # @param second [::String]
    #
    # @return [::String]
    #
    # @example Basics
    #   F::String.concat("123", "456") #=> "123456"
    #
    # @example Curried
    #   curried = F::String.concat
    #   curried.("123").("456") #=> "123456"
    #
    # @example Curried with placeholder
    #   curried = F::String.concat(F._, "456")
    #   curried.("123") #=> "123456"
    def concat(first = F._, second = F._)
      curry_implementation(:concat, first, second)
    end

    private

    def _split(splitter, string)
      _string(string).split(splitter)
    end

    def _concat(first, second)
      _string(first) + _string(second)
    end

    def _string(string)
      string.to_s
    end
  end
end
