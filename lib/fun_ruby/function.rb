# frozen_string_literal: true

require_relative "common/helpers"

# Top-level
module FunRuby
  # Module for useful manipulations with functions
  module Function
    extend self

    # Performs right-to-left function composition
    #
    # @since 0.1.0
    #
    # @param required [#call]
    # @param *functions [#call]
    #
    # @return [#call]
    #
    # @example Basic: one function
    #   plus_2 = ->(x) { x + 2 }
    #
    #   curried = F::Function.compose(plus_2)
    #   curried.(2) # => 4
    #
    # @example Basic: two functions
    #   plus_2 = ->(x) { x + 2 }
    #   multiply_3 = ->(x) { x * 3 }
    #
    #   # multiplying -> adding
    #   curried = F::Function.compose(plus_2, multiply_3)
    #
    #   curried.(2) # => 8
    #
    #   # adding ->  multiplying
    #   curried = F::Function.compose(multiply_3, plus_2)
    #
    #   curried.(2) # => 12
    #
    # @example Basic: three functions
    #   plus_2 = ->(x) { x + 2 }
    #   multiply_3 = ->(x) { x * 3 }
    #   mod_4 = ->(x) { x % 4 }
    #
    #   # multiplying -> adding -> mod
    #   curried = F::Function.compose(mod_4, plus_2, multiply_3)
    #   curried.(4) # => 2
    def compose(required = F._, *functions)
      curry(method(:_compose)).(required, *functions)
    end

    # Performs left-to-right function composition
    #
    # @since 0.1.0
    #
    # @param required [#call]
    # @param *functions [#call]
    #
    # @return [#call]
    #
    # @example Basic: one function
    #   plus_2 = ->(x) { x + 2 }
    #
    #   curried = F::Function.pipe(plus_2)
    #   curried.(2) # => 4
    #
    # @example Basic: two functions
    #   plus_2 = ->(x) { x + 2 }
    #   multiply_3 = ->(x) { x * 3 }
    #
    #   # multiplying -> adding
    #   curried = F::Function.pipe(multiply_3, plus_2)
    #
    #   curried.(2) # => 8
    #
    #   # adding ->  multiplying
    #   curried = F::Function.pipe(plus_2, multiply_3)
    #
    #   curried.(2) # => 12
    #
    # @example Basic: three functions
    #   plus_2 = ->(x) { x + 2 }
    #   multiply_3 = ->(x) { x * 3 }
    #   mod_4 = ->(x) { x % 4 }
    #
    #   # multiplying -> adding -> mod
    #   curried = F::Function.pipe(multiply_3, plus_2,  mod_4)
    #   curried.(4) # => 2
    def pipe(required = F._, *functions)
      curry(method(:_pipe)).(required, *functions)
    end

    # @example
    #   build_ary = ->(a, b, c) { [a, b, c] }
    #   curry = F::Function.curry
    #   curried = curry.(build_ary)
    #
    #   curried.(1, 2, 3) # => [1, 2, 3]
    #   curried.(1).(2).(3) # => [1, 2, 3]
    #   curried.(F._, 2).(F._, 3).(1) # => [1, 2, 3]
    #   curried.(F._, 2, F._).(1).(3) # => [1, 2, 3]
    #   curried.(F._, F._, 3).(F._, 2).(1) # => [1, 2, 3]
    #   curried.(F._, 2, F._).(1, 3) # => [1, 2, 3]
    #   curried.(F._, 2, F._).(1, 3) # => [1, 2, 3]
    def curry(function = F._)
      handling_placeholders(method(:_curry).curry, [function])
    end

    private

    def _pipe(required, *functions)
      functions = [required, *functions]
      functions.reduce do |composed, function|
        ->(*args) { function.(composed.(*args)) }
      end
    end

    def _compose(required, *functions)
      _pipe(*functions, required)
    end

    def _curry(function)
      handling_placeholders(function.curry)
    end

    def handling_placeholders(function, processed_args = [], *new_args)
      processed_args, _ = new_args.reduce([processed_args, 0], &method(:apply_arg))
      values, with_placeholders = bisect_args(processed_args)
      result = function.(*values)
      return result unless result.respond_to?(:call)

      ->(*args) { handling_placeholders(result, with_placeholders, *args) }
    end

    def apply_arg((processed_args, shift), new_arg)
      processed_args = processed_args.dup
      placeholder_index = processed_args[shift..-1].to_a.index(F._)
      if placeholder_index
        real_position = placeholder_index + shift
        processed_args[real_position] = new_arg
        [processed_args, real_position + 1]
      else
        processed_args << new_arg
        [processed_args, processed_args.size]
      end
    end

    def bisect_args(args)
      index = args.index(F._)
      return [args, []] if index.nil?

      values = args[0...index]
      placeholders = args[index..-1] || []
      [values, placeholders]
    end
  end
end
