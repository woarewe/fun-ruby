# frozen_string_literal: true

module FunRuby
  module Array
    include Core

    def size(array = nil)
      _curried(:array, array)
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
