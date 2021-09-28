# frozen_string_literal: true

module FunRuby
  PLACEHOLDER = Object.new.freeze

  def self._
    PLACEHOLDER
  end

  module Core
    def _curried(function_name, *args)
      original_curried = method("_#{function_name}").curry
      ->(*new_args) {
        _handler(original_curried, args.compact, *new_args)
      }
    end

    def _handler(function, saved_args, *new_args)
      merged = new_args.each_with_object(saved_args.dup) do |new_arg, saved|
        if new_arg == PLACEHOLDER
          saved << new_arg
          next
        end

        placeholder_index = saved.index(PLACEHOLDER)
        if placeholder_index
          saved[placeholder_index] = new_arg
          next
        end

        saved << new_arg
      end

      if merged.include?(PLACEHOLDER)
        return ->(*args) { _handler(function, merged, *args) }
      end

      result = function.(*merged)
      return result unless result.is_a?(Proc)

      ->(*args) { _handler(result, [], *args) }
    end
  end
end
