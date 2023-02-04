# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Hash
      # Returns a value stored by a given key.
      # If there is no given key it raises error
      #
      # @since 0.1.0
      #
      # @param key [#hash, #eql?]
      # @param hash [#to_h]
      #
      # @return [Object]
      #
      # @raise KeyError
      #
      # @example Base
      #   hash = { age: 20, name: 'John' }
      #   F::Modules::Hash.fetch(:age, hash) # => 20
      #   F::Modules::Hash.fetch(:name, hash) # => 'John'
      #   F::Modules::Hash.fetch(:email, hash) # => raise KeyError, "key not found: :email"
      #
      # @example Curried
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.fetch
      #   curried.(:age, hash) # => 20
      #   curried.(:name).(hash) # => 'John'
      #   curried.(:email).(hash) # => raise KeyError, "key not found: :email"
      #
      # @example Curried with placeholders
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.fetch(F._, hash)
      #   curried.(:age) # => 20
      #   curried.(:name) # => 'John'
      def fetch(key = F._, hash = F._)
        curry_implementation(:fetch, key, hash)
      end
    end
  end
end
