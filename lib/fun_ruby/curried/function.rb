# frozen_string_literal: true

module FunRuby
  module Curried
    class Function
      attr_reader :function, :curried, :arguments, :rules

      def initialize(params = {})
        @function = params.fetch(:function)
        @curried = params.fetch(:curried) { @function.curry }
        @arguments = params.fetch(:arguments) do
          @function.parameters.each_with_object({}) { |(_type, name), arguments| arguments[name] = nil }
        end
        @rules = params.fetch(:rules, {})
      end

      def call(*args)
        raise ArgumentError if unassigned_arguments.size < args.size

        new_arguments = unassigned_arguments.keys.zip(args).to_h.compact
        result = new_arguments.inject(curried) do |curried, (argument, value)|
          rules[argument] && rules[argument].(value)
          curried.(value)
        end
        return result if unassigned_arguments.size == args.size

        self.class.new(
          function: function,
          curried: result,
          arguments: arguments.merge(new_arguments),
          rules: rules
        )
      end

      private

      def unassigned_arguments
        arguments.select { |_argument, value| value.nil? }
      end
    end
  end
end
