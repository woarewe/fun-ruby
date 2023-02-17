# frozen_string_literal: true

require "forwardable"

module FunRuby
  module Container
    # Holds DSL for allowing using in classes/modules
    module DSL
      def_delegator :_fun_ruby_define_api, :function, :f, :namespace

      def [](key)
        _fun_ruby_resolve_api.call(key0)
      end

      private

      def _fun_ruby_container
        @_fun_ruby_container ||= Container.new(
          Config.new(override: true)
        )
      end

      def _fun_ruby_define_api
        @_fun_ruby_define_api ||= Define.build(_fun_ruby_container)
      end

      def _fun_ruby_resolve_api
        @_fun_ruby_resolve_api ||= Resolve.build(_fun_ruby_container)
      end
    end
  end
end
