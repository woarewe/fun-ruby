# frozen_string_literal: true

require_relative "core"

# Top-level
module FunRuby
  # Module for useful manipulations with functions
  module Function
    include Core

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
    def compose(required = _, *functions)
      curried(:compose, required, *functions)
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
    def pipe(required = _, *functions)
      curried(:pipe, required, *functions)
    end
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
end
