# frozen_string_literal: true

require_relative "core"

module FunRuby
  module Enum
    include Core

    extend self

    def all?(function = _, enumerable = _)
      curried(:all?, function, enumerable)
    end

    def any?(function = _, enumerable = _)
      curried(:any?, function, enumerable)
    end

    def chain(enumerable = _, *enumerables)
      curried(:chain, enumerable, *enumerables)
    end

    def chunk(function = _, enumerable = _)
      curried(:chunk, function, enumerable)
    end

    def chunk_while(function = _, enumerable = _)
      curried(:chunk_while, function, enumerable)
    end

    def count_by(function = _, enumerable = _)
      curried(:count_by, function, enumerable)
    end

    def take(amount = _, enumerable = _)
      curried(:take, amount, enumerable)
    end

    def each(function = _, enumerable = _)
      curried(:each, function, enumerable)
    end

    def map(function = _, enumerable = _)
      curried(:map, function, enumerable)
    end

    def select(function = _, enumerable = _)
      curried(:select, function, enumerable)
    end

    private

    def _all?(function, enumerable)
      _enum(enumerable).all?(&function)
    end

    def _any?(function, enumerable)
      _enum(enumerable).any?(&function)
    end

    def _chain(enumerable, *enumerables)
      _enum(enumerable).chain(*enumerables)
    end

    def _chunk(function, enumerable)
      _enum(enumerable).chunk(&function)
    end

    def _chunk_while(function, enumerable)
      _enum(enumerable).chunk_while(&function)
    end

    def _count_by(function, enumerable)
      _enum(enumerable).count(&function)
    end

    def _take(amount, enumerable)
      _enum(enumerable).take(amount)
    end

    def _each(function, enumerable)
      _enum(enumerable).each(&function)
    end

    def _map(function, enumerable)
      _enum(enumerable).map(&function)
    end

    def _select(function, enumerable)
      _enum(enumerable).select(&function)
    end

    def _enum(enumerable)
      enumerable.to_enum
    end
  end
end
