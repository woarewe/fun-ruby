# frozen_string_literal: true

require_relative "core"

module FunRuby
  module Array
    include Core

    extend self

    def size(array = _)
      curried(:size, array)
    end

    private

    def _size(array)
      _array(array).size
    end

    def _array(array)
      array.to_a
    end
  end
end
