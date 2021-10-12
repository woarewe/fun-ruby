# frozen_string_literal: true

# Top-level namespace
module FunRuby
  PLACEHOLDER = Object.new.freeze

  extend self

  def define(&block)
    container
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
