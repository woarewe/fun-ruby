# frozen_string_literal: true

require_relative "core"

module FunRuby
  module String
    include Core

    extend self

    def match(regexp = _, string = _)
      curried(regexp, string)
    end

    def match?(regexp = _, string = _)
      curried(:match?, regexp, string)
    end

    def split(splitter = _, string = _)
      curried(:split, splitter, string)
    end

    private

    def _match(regexp, string)
      regexp.match(_string(string))
    end

    def _match?(regexp, string)
      regexp.match?(_string(string))
    end

    def _split(splitter, string)
      _string(string).split(splitter)
    end

    def _string(string)
      string.to_s
    end
  end
end
