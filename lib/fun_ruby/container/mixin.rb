# frozen_string_literal: true

require_relative "resolve"

module FunRuby
  class Container
    module Mixin
      def self.build(aliases:)
        mixin = Module.new
        mixin.send(:define_method, :resolve) { Resolve.build(aliases: aliases) }
        mixin.send(:include, self)
        mixin
      end

      private

      def resolve
        @resolve ||= Resolve.build
      end

      def f(key)
        resolve.(key)
      end
    end
  end
end
