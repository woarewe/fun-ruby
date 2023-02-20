# frozen_string_literal: true

require_relative "resolve"

module FunRuby
  class Container
    # @private
    module Mixin
      # @private
      def self.build(aliases:, container:)
        mixin = Module.new
        mixin.send(:define_method, :_resolve) { Resolve.build(aliases: aliases, container: container) }
        mixin.send(:include, self)
        mixin
      end

      private

      def f(key)
        _resolve.(key)
      end
    end
  end
end
