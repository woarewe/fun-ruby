# frozen_string_literal: true

module FunRuby
  # Module containing methods for hashes
  module Hash
    include Common::Helpers

    extend self

    # Returns a value stored by a given key.
    # If there is no given key it return a default value
    #
    # @since 0.1.0
    #
    # @param key [#hash, #eql?]
    # @param hash [#to_hash]
    #
    # @return [Object]
    #
    # @example Base
    #
    #   hash = { age: 20, name: 'John' }
    #   F::Hash.get(:age, hash) # => 20
    #   F::Hash.get(:name, hash) # => 'John'
    #   F::Hash.get(:email, hash) # => nil
    def get(key = F._, hash = F._)
      curry_implementation(:get, key, hash)
    end

    private

    def _get(key, hash)
      _hash(hash)[key]
    end

    def _hash(hash)
      hash.to_h
    end
  end
end
