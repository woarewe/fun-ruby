# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Hash
      # Returns a value stored by a given key.
      # If there is no given key it calls a given fallback.
      #
      # @since 0.1.0
      #
      # @param key [#hash, #eql?]
      # @param fallback [#to_call]
      # @param hash [#to_h]
      #
      # @return [Object]
      #
      # @example Base
      #   hash = { age: 20, name: 'John' }
      #   F::Modules::Hash.fetch_with(:age, ->(_) { :fallback }, hash) # => 20
      #   F::Modules::Hash.fetch_with(:name, ->(_) { :fallback }, hash) # => 'John'
      #   F::Modules::Hash.fetch_with(:email, ->(_) { :fallback }, hash) # => :fallback
      #
      # @example Curried
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.fetch_with
      #   curried.(:age, ->(_) { :fallback }, hash) # => 20
      #   curried.(:name).(->(_) { :fallback }).(hash) # => 'John'
      #   curried.(:email).(->(_) { :fallback }).(hash) # => :fallback
      #
      # @example Curried with placeholders
      #   hash = { age: 20, name: 'John' }
      #   curried = F::Modules::Hash.fetch_with(F._, F._, F._)
      #   curried.(:age).(->(_) { :fallback }).(hash) # => 20
      #
      #   curried = F::Modules::Hash.fetch_with(F._, ->(_) { :fallback }, F._)
      #   curried.(:age).(hash) # => 20
      #   curried.(:email).(hash) # => :fallback
      def fetch_with(key = F._, fallback = F._, hash = F._)
        curry_implementation(:fetch_with, key, fallback, hash)
      end
    end
  end
end
