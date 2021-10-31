# frozen_string_literal: true

require_relative "fun_ruby/container"
require_relative "fun_ruby/container/define"

# Top-level namespace
module FunRuby
  PLACEHOLDER = Object.new.freeze

  extend self

  def define(&block)
    Container::Define.build(container: container).(&block)
  end

  def container
    @container ||= Container.new
  end

  # A placeholder that helps to use not positioned currying
  def _
    PLACEHOLDER
  end
end

F = FunRuby
