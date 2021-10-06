# frozen_string_literal: true

require_relative "../fun_ruby"

module FunRuby
  module Core
    def _
      PLACEHOLDER
    end

    def curry(&block)
      handler([], &block.curry)
    end

    def handler(saved_args = [], *new_args, &curried)
      values, with_placeholders = bisect_pure_values(_, new_args)

      saved_args = values.compact.each_with_object(saved_args.dup) do |value, ary|
        placeholder_index = ary.index(_)
        if placeholder_index
          ary[placeholder_index] = value
          next
        end
        ary << value
      end

      saved_args += with_placeholders
      values, with_placeholders = bisect_pure_values(_, saved_args)
      result = curried.(*values)
      return result unless result.respond_to?(:call)

      ->(*args) { handler(with_placeholders, *args, &result) }
    end

    def curried(method_name, *args)
      curry(&method("_#{method_name}")).(*args)
    end

    def bisect_pure_values(separator, ary)
      index = ary.index(separator)
      return [ary, []] if index.nil?

      values = ary[0...index]
      placeholders = ary[index..-1] || []
      [values, placeholders]
    end
  end

  private_constant :Core
end
