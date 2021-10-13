# frozen_string_literal: true

require_relative "resolve"

module FunRuby
  class Container
    module Mixin
      private

      def resolve
        @resolve ||= Resolve.build
      end

      def f(key)
        resolve.(key)
      end

      def self.build(*params)
        mixin = Module.new
        mixin.send(:define_method, :resolve) { Resolve.build(*params) }
        mixin.send(:include, self)
        mixin
      end
    end
  end
end
