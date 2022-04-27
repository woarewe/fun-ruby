# frozen_string_literal: true

require_relative "fun_ruby/container"
require_relative "fun_ruby/container/define"

# Top-level namespace
module FunRuby
  PLACEHOLDER = Object.new.freeze

  extend self

  # Allows to define globally available functions
  #
  # @since 0.1.0
  #
  # @return void
  #
  # @example Basic: defines a function
  #   F.define do
  #     namespace :functions do
  #       f(:sum) { ->(x, y) { x + y } }
  #     end
  #   end
  #   F.container.fetch("functions.sum").(2, 3) # => 5
  def define(&block)
    Container::Define.build(container: container).(&block)
  end

  # Returns a global container
  #
  # @since 0.1.0
  #
  # @return [FunRuby::Container]
  def container
    @container ||= Container.new
  end

  # Return a global container mixin
  #
  # @since 0.1.0
  #
  # @return [FunRuby::Container::Mixin]
  def mixin(*aliases)
    container.mixin(*aliases)
  end

  # A placeholder that helps to use not positioned currying
  def _
    PLACEHOLDER
  end
end

F = FunRuby
