# frozen_string_literal: true

require_relative "core"

module FunRuby
  # Module containing methods for strings
  module String
    include Core

    extend self

    # Split a string by a passed delimiter
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
    def split(splitter = _, string = _)
      curried(:split, splitter, string)
    end

    private

    def _split(splitter, string)
      _string(string).split(splitter)
    end

    def _string(string)
      string.to_s
    end
  end
end
