# frozen_string_literal: true

module FunRuby
  module Modules
    # Module containing methods for hashes
    # TODO: Split the file into smaller chunks
    module Hash # rubocop:disable Metrics/ModuleLength
      include Common::Helpers

      extend self

      # Merges two hashes. The key-value pairs from the second to the first.
      # If the key is already taken the current value will be replaced.
      #
      # @since 0.1.0
      #
      # @param first [#to_h]
      # @param second [#to_h]
      #
      # @return [Hash]
      #
      # @example Base
      #   first = { name: "John" }
      #   second = { age: 20 }
      #   F::Modules::Hash.merge(first, second) # => { name: "John", age: 20 }
      #
      #   first = { name: "John" }
      #   second = { name: "Bill", age: 20 }
      #   F::Modules::Hash.merge(first, second) # => { name: "Bill", age: 20 }
      #
      # @example Curried
      #   first = { name: "John" }
      #   second = { age: 20 }
      #   curried = F::Modules::Hash.merge
      #   curried.(first).(second) # => { name: "John", age: 20 }
      #
      #   first = { name: "John" }
      #   second = { name: "Bill", age: 20 }
      #   curried = F::Modules::Hash.merge
      #   curried.(first).(second) # => { name: "Bill", age: 20 }
      #
      # @example Curried with placeholders
      #   first = { name: "John" }
      #   second = { age: 20 }
      #   curried = F::Modules::Hash.merge(F._, F._)
      #   curried.(first).(second) # => { name: "John", age: 20 }
      #
      #   first = { name: "John" }
      #   second = { name: "Bill", age: 20 }
      #   curried = F::Modules::Hash.merge(F._, second)
      #   curried.(first) # => { name: "Bill", age: 20 }
      def merge(first = F._, second = F._)
        curry_implementation(:merge, first, second)
      end

      # Builds a new hash with only given keys from a given hash.
      # If keys are missed in the given hash the corresponded key will be absent
      # in the result hash.
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      #
      # @return [Hash]
      #
      # @example Base
      #   hash = { name: "John", age: 20, email: "john@gmail.com", country: "USA" }
      #
      #   F::Modules::Hash.slice([:name, :age, :country], hash) # => { name: "John", age: 20, country: "USA" }
      #   F::Modules::Hash.slice([:name, :age, :address], hash) # => { name: "John", age: 20 }
      #
      # @example Curried
      #   hash = { name: "John", age: 20, email: "john@gmail.com", country: "USA" }
      #   curried = F::Modules::Hash.slice
      #
      #   curried.([:name, :age, :country]).(hash) # => { name: "John", age: 20, country: "USA" }
      #   curried.([:name, :age, :address]).(hash) # => { name: "John", age: 20 }
      #
      # @example Curried with placeholders
      #   hash = { name: "John", age: 20, email: "john@gmail.com", country: "USA" }
      #
      #   curried = F::Modules::Hash.slice(F._, hash)
      #   curried.([:name, :age, :country]) # => { name: "John", age: 20, country: "USA" }
      #   curried.([:name, :age, :address]) # => { name: "John", age: 20 }
      def slice(keys = F._, hash = F._)
        curry_implementation(:slice, keys, hash)
      end

      # Builds a new hash with only given keys from a given hash.
      # If keys are missed in the given hash KeyError is raised
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      #
      # @return [Hash]
      #
      # @example Base
      #   hash = { name: "John", age: 20, country: "USA" }
      #
      #   F::Modules::Hash.slice!([:name, :age, :country], hash) # => { name: "John", age: 20, country: "USA" }
      #   F::Modules::Hash.slice!([:address, :email], hash) # => raise KeyError, "keys not found: [:address, :email]"
      def slice!(keys = F._, hash = F._)
        curry_implementation(:slice!, keys, hash)
      end

      # Returns an array of values stored by given keys
      # If any key is missed in the given hash KeyError is raised with the first missed key
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { name: "John", age: 20, country: "USA" }
      #
      #   F::Modules::Hash.fetch_values([:name, :age, :country], hash) # => ["John", 20, "USA"]
      #   F::Modules::Hash.fetch_values([:address, :email], hash) # => raise KeyError, "key not found: :address"
      def fetch_values(keys = F._, hash = F._)
        curry_implementation(:fetch_values, keys, hash)
      end

      # Returns an array of values stored by given keys
      # If a key is missed the default value is returned
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { name: "John", age: 20, country: "USA" }
      #
      #   F::Modules::Hash.values_at([:name, :age, :country], hash) # => ["John", 20, "USA"]
      #   F::Modules::Hash.values_at([:address, :email, :country, :age], hash) # => [nil, nil, "USA", 20]
      def values_at(keys = F._, hash = F._)
        curry_implementation(:values_at, keys, hash)
      end

      # Returns an array of all stored values
      #
      # @since 0.1.0
      #
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   F::Modules::Hash.values({}) # => []
      #   F::Modules::Hash.values({ age: 33 }) # => [33]
      #   F::Modules::Hash.values({ age: 33, name: "John"}) # => [33, "John"]
      def values(hash = F._)
        curry_implementation(:values, hash)
      end

      # Returns an array of all stored keys
      #
      # @since 0.1.0
      #
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   F::Modules::Hash.keys({}) # => []
      #   F::Modules::Hash.keys({ age: 33 }) # => [:age]
      #   F::Modules::Hash.keys({ age: 33, name: "John"}) # => [:age, :name]
      def keys(hash = F._)
        curry_implementation(:keys, hash)
      end

      # Returns a new hash containing only pairs
      # for which a given function returns true
      #
      # @since 0.1.0
      #
      # @param function [#call/2]
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { 'a' => 1, 'b' => 2, :c => 3, :d => 4 }
      #   F::Modules::Hash.select(->(key, _value) { key.is_a?(String) }, hash) # => { 'a' => 1, 'b' => 2 }
      #   F::Modules::Hash.select(->(_key, value) { value.odd? }, hash) # => { 'a' => 1, :c => 3 }
      def select(function = F._, hash = F._)
        curry_implementation(:select, function, hash)
      end

      # Returns a new hash excluding pairs
      # for which a given function returns true
      #
      # @since 0.1.0
      #
      # @param function [#call/2]
      # @param hash [#to_h]
      #
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { 'a' => 1, 'b' => 2, :c => 3, :d => 4 }
      #   F::Modules::Hash.reject(->(key, _value) { key.is_a?(String) }, hash) # => { :c => 3, :d => 4 }
      #   F::Modules::Hash.reject(->(_key, value) { value.odd? }, hash) # => { 'b' => 2, :d =>4 }
      def reject(function = F._, hash = F._)
        curry_implementation(:reject, function, hash)
      end

      # Returns a value stored by a given chain of keys.
      # If a value of any level key of the chain is not found nil is returned.
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { a: { b: { c: 3 } } }
      #   F::Modules::Hash.dig([:a], hash) # => { b: { c: 3 } }
      #   F::Modules::Hash.dig([:a, :b], hash) # => { c: 3 }
      #   F::Modules::Hash.dig([:a, :b, :c], hash) # => 3
      #   F::Modules::Hash.dig([:foo], hash) # => nil
      #   F::Modules::Hash.dig([:a, :foo], hash) # => nil
      #   F::Modules::Hash.dig([:a, :b, :foo], hash) # => nil
      def dig(keys = F._, hash = F._)
        curry_implementation(:dig, keys, hash)
      end

      # Returns a value stored by a given chain of keys.
      # If a value of any level key of the chain is not found KeyError is raised
      #
      # @since 0.1.0
      #
      # @param keys [::Array of (#hash, #eql?)]
      # @param hash [#to_h]
      # @return [::Array[Object]]
      #
      # @example Base
      #   hash = { a: { b: { c: 3 } } }
      #   F::Modules::Hash.dig!([:a], hash) # => { b: { c: 3 } }
      #   F::Modules::Hash.dig!([:a, :b], hash) # => { c: 3 }
      #   F::Modules::Hash.dig!([:a, :b, :c], hash) # => 3
      #   F::Modules::Hash.dig!([:foo], hash) # => raise KeyError, "key not found: :foo"
      #   F::Modules::Hash.dig!([:a, :foo], hash) # => raise KeyError, "key not found: :foo"
      #   F::Modules::Hash.dig!([:a, :b, :foo], hash) # => raise KeyError, "key not found: :foo"
      def dig!(keys = F._, hash = F._)
        curry_implementation(:dig!, keys, hash)
      end

      # Returns a new hash without all key-valued pairs
      #
      # @since 0.1.0
      #
      # @param hash [#to_h]
      #
      # @example Base
      #   hash = { name: "John", age: 18, email: nil, country: nil }
      #   F::Modules::Hash.compact(hash) # => { name: "John", age: 18 }
      def compact(keys = F._, hash = F._)
        curry_implementation(:compact, keys, hash)
      end

      # Returns a new hash with updated keys calculated
      # as a result returned from a given function
      #
      # @since 0.1.0
      #
      # @param function [#call/1]
      # @param hash [#to_h]
      #
      # @example Base
      #   hash = { a: 1, b: 2, c: 3 }
      #   F::Modules::Hash.transform_keys(->(key) { key.to_s }, hash) #=> { 'a' => 1, 'b' => 2, 'c' => 3 }
      def transform_keys(function = F._, hash = F._)
        curry_implementation(:transform_keys, function, hash)
      end

      # Returns a new hash with updated values calculated
      # as a result returned from a given function
      #
      # @since 0.1.0
      #
      # @param function [#call/1]
      # @param hash [#to_h]
      #
      # @example Base
      #   hash = { a: 1, b: 2, c: 3 }
      #   F::Modules::Hash.transform_values(->(value) { value.to_s }, hash) #=> { a: '1', b: '2', c: '3' }
      def transform_values(function = F._, hash = F._)
        curry_implementation(:transform_values, function, hash)
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

      def _put(key, value, hash)
        _hash(hash).merge(key => value)
      end

      def _merge(first, second)
        _hash(first).merge(_hash(second))
      end

      if RUBY_VERSION >= "2.5"
        def _slice(keys, hash)
          _hash(hash).slice(*keys)
        end
      else
        def _slice(keys, hash)
          hash = _hash(hash)
          keys.each_with_object({}) do |key, new_hash|
            new_hash[key] = hash[key] if hash.key?(key)
          end
        end
      end

      def _slice!(keys, hash)
        hash = _hash(hash)
        missed_keys = keys - hash.keys
        raise KeyError, "keys not found: #{missed_keys.inspect}" if missed_keys.any?

        _slice(keys, hash)
      end

      def _fetch_values(keys, hash)
        _hash(hash).fetch_values(*keys)
      end

      def _values_at(keys, hash)
        _hash(hash).values_at(*keys)
      end

      def _values(hash)
        _hash(hash).values
      end

      def _keys(hash)
        _hash(hash).keys
      end

      def _select(function, hash)
        _hash(hash).select(&function)
      end

      def _reject(function, hash)
        _hash(hash).reject(&function)
      end

      def _dig(keys, hash)
        _hash(hash).dig(*keys)
      end

      def _dig!(keys, hash)
        hash = _hash(hash)
        keys.reduce(hash) { |current, key| current.fetch(key) }
      end

      if RUBY_VERSION >= "2.4"
        def _compact(hash)
          _hash(hash).compact
        end
      else
        def _compact(hash)
          _hash(hash).reject { |_key, value| value.nil? }
        end
      end

      if RUBY_VERSION >= "2.5"
        def _transform_keys(function, hash)
          _hash(hash).transform_keys(&function)
        end
      else
        def _transform_keys(function, hash)
          hash = _hash(hash)
          hash.each_with_object({}) do |(key, value), new_hash|
            new_key = function.(key)
            new_hash[new_key] = value
          end
        end
      end

      if RUBY_VERSION >= "2.4"
        def _transform_values(function, hash)
          _hash(hash).transform_values(&function)
        end
      else
        def _transform_values(function, hash)
          hash = _hash(hash)
          hash.each_with_object({}) do |(key, value), new_hash|
            new_value = function.(value)
            new_hash[key] = new_value
          end
        end
      end

      def _hash(hash)
        hash.to_h
      end
    end
  end
end

require_relative "hash/get"
require_relative "hash/fetch"
require_relative "hash/fetch_with"
require_relative "hash/put"
