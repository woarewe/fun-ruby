# frozen_string_literal: true

module FunRuby
  PLACEHOLDER = Object.new.freeze

  def self._
    PLACEHOLDER
  end
end

F = FunRuby
