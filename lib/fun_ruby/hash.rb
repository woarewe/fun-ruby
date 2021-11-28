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
    #
    # @example Curried
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.get
    #   curried.(:age, hash) # => 20
    #   curried.(:name).(hash) # => 'John'
    #
    # @example Curried
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.get
    #   curried.(:age, hash) # => 20
    #   curried.(:name).(hash) # => 'John'
    #
    # @example Curried with placeholders
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.get(F._, hash)
    #   curried.(:age) # => 20
    #   curried.(:name) # => 'John'
    def get(key = F._, hash = F._)
      curry_implementation(:get, key, hash)
    end

    # Returns a value stored by a given key.
    # If there is no given key it raises error
    #
    # @since 0.1.0
    #
    # @param key [#hash, #eql?]
    # @param hash [#to_hash]
    #
    # @return [Object]
    #
    # @raise KeyError
    #
    # @example Base
    #
    #   hash = { age: 20, name: 'John' }
    #   F::Hash.fetch(:age, hash) # => 20
    #   F::Hash.fetch(:name, hash) # => 'John'
    #   F::Hash.fetch(:email, hash) # => raise KeyError, "key not found: :email"
    #
    # @example Curried
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.fetch
    #   curried.(:age, hash) # => 20
    #   curried.(:name).(hash) # => 'John'
    #   curried.(:email).(hash) # => raise KeyError, "key not found: :email"
    #
    # @example Curried with placeholders
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.fetch(F._, hash)
    #   curried.(:age) # => 20
    #   curried.(:name) # => 'John'
    def fetch(key = F._, hash = F._)
      curry_implementation(:fetch, key, hash)
    end

    # Returns a value stored by a given key.
    # If there is no given key it calls a given fallback.
    #
    # @since 0.1.0
    #
    # @param key [#hash, #eql?]
    # @param fallback [#to_call]
    # @param hash [#to_hash]
    #
    # @return [Object]
    #
    #
    # @example Base
    #
    #   hash = { age: 20, name: 'John' }
    #   F::Hash.fetch_with(:age, ->(_) { :fallback }, hash) # => 20
    #   F::Hash.fetch_with(:name, ->(_) { :fallback }, hash) # => 'John'
    #   F::Hash.fetch_with(:email, ->(_) { :fallback }, hash) # => :fallback
    #
    # @example Curried
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.fetch_with
    #   curried.(:age, ->(_) { :fallback }, hash) # => 20
    #   curried.(:name).(->(_) { :fallback }).(hash) # => 'John'
    #   curried.(:email).(->(_) { :fallback }).(hash) # => :fallback
    #
    # @example Curried with placeholders
    #
    #   hash = { age: 20, name: 'John' }
    #   curried = F::Hash.fetch_with(F._, F._, F._)
    #   curried.(:age).(->(_) { :fallback }).(hash) # => 20
    #
    #   curried = F::Hash.fetch_with(F._,->(_) { :fallback }), F._)
    #   curried.(:age).(hash) # => 20
    #   curried.(:email).(hash) # => :fallback
    def fetch_with(key = F._, fallback = F._, hash = F._)
      curry_implementation(:fetch_with, key, fallback, hash)
    end

    private

    def _get(key, hash)
      _hash(hash)[key]
    end

    def _fetch(key, hash)
      _hash(hash).fetch(key)
    end

    def _fetch_with(key, fallback, hash)
      _hash(hash).fetch(key, &fallback)
    end

    def _hash(hash)
      hash.to_h
    end
  end
end
