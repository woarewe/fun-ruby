# frozen_string_literal: true

require_relative "resolve"

module FunRuby
  class Container
    # @private
    module Mixin
      # @private
      def self.build(aliases:)
        mixin = Module.new
        mixin.send(:define_method, :_resolve) { Resolve.build(aliases: aliases) }
        mixin.send(:include, self)
        mixin
      end

      private

      def _resolve
        @_resolve ||= Resolve.build
      end

      def f(key)
        _resolve.(key)
      end
    end
  end
end
