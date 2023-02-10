# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Hash
      # Puts a value by a given key.
      # If the key is already taken the current value will be replaced.
      #
      # @since 0.1.0
      #
      # @param key [#hash, #eql?]
      # @param value [Object]
      # @param hash [#to_h]
      #
      # @return [Hash]
      #
      # @example Base
      #   hash = { name: "John" }
      #   F::Modules::Hash.put(:age, 20, hash) # => { name: "John", age: 20 }
      #   F::Modules::Hash.put(:name, "Peter", hash) # => { name: "Peter" }
      #
      # @example Curried
      #   hash = { name: "John" }
      #   curried = F::Modules::Hash.put
      #   curried.(:age).(20).(hash) # => { name: "John", age: 20 }
      #   curried.(:name).("Peter").(hash) # => { name: "Peter" }
      #
      # @example Curried with placeholders
      #   hash = { name: "John" }
      #   curried = F::Modules::Hash.put(F._, 20, hash)
      #   curried.(:age) # => { name: "John", age: 20 }
      #
      #   curried = F::Modules::Hash.put(F._, 20, F._)
      #   curried.(:age).(hash) # => { name: "John", age: 20 }
      #
      #   curried = F::Modules::Hash.put(:age, F._, hash)
      #   curried.(20) # => { name: "John", age: 20 }
      def put(key = F._, value = F._, hash = F._)
        curry_implementation(:put, key, value, hash)
      end
    end
  end
end
