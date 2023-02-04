# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Hash
      # Returns a value stored by a given key.
      # If there is no given key it return a default value
      #
      # @since 0.1.0
      #
      # @param key [#hash, #eql?]
      # @param hash [#to_h]
      #
      # @return [Object]
      #
      # @example Base
      #   hash = { age: 20, name: 'John' }
      #   F::Modules::Hash.get(:age, hash) # => 20
      #   F::Modules::Hash.get(:name, hash) # => 'John'
      #   F::Modules::Hash.get(:email, hash) # => nil
      #
      # @example Curried
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.get
      #   curried.(:age, hash) # => 20
      #   curried.(:name).(hash) # => 'John'
      #
      # @example Curried
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.get
      #   curried.(:age, hash) # => 20
      #   curried.(:name).(hash) # => 'John'
      #
      # @example Curried with placeholders
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.get(F._, hash)
      #   curried.(:age) # => 20
      #   curried.(:name) # => 'John'
      def get(key = F._, hash = F._)
        curry_implementation(:get, key, hash)
      end
    end
  end
end
