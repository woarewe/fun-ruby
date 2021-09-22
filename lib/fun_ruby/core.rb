# frozen_string_literal: true

module FunRuby
  module Core
    def _curried_args(*args)
      args.compact
    end

    def _curried(function_name, *args)
      method("_#{function_name}").curry.(*_curried_args(*args))
    end
  end
end
