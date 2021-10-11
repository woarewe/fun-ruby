# frozen_string_literal: true

require_relative "../../fun_ruby"
require_relative "../function"

module FunRuby
  module Common
    # Helpers for shorting internal implementations
    module Helpers
      private

      def curry_implementation(method_name, *args)
        F::Function.curry(method("_#{method_name}")).(*args)
      end
    end
  end

  private_constant :Common
end
