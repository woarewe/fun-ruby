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
  def define(target = nil, &block)
    target ||= container
    Container::Define.build(container: target).(&block)
  end

  # Returns a global container
  #
  # @since 0.1.0
  #
  # @return [FunRuby::Container]
  def container
    @container ||= Container.new
  end

  # Accepts a container that will be considered global
  #
  # @since 0.1.0
  #
  # @return [FunRuby::Container]
  def container=(container)
    raise ArgumentError, "The global container is already defined" if instance_variable_defined?(:@container)

    @container = container
  end

  # Allows to import global container to your classes and modules
  #
  # @since 0.1.0
  #
  # @return [FunRuby::Container::Mixin]
  #
  # @example
  #   F.define do
  #     namespace :app do
  #       namespace :string do
  #         f(:to_s) { ->(x) { x.to_s } }
  #         f(:map) { F::Modules::Enum.map(f(:to_s)) }
  #       end
  #
  #       namespace :math do
  #         f(:x2) { ->(x) { x * 2 } }
  #         f(:map) { F::Modules::Enum.map(f(:x2)) }
  #       end
  #     end
  #   end
  #
  #   class Service
  #     include F.import(
  #       "app.string" => "s",
  #       "app.math" => "m"
  #     )
  #
  #     def s_map(ary)
  #       f("s.map").(ary)
  #     end
  #
  #     def m_map(ary)
  #       f("m.map").(ary)
  #     end
  #   end
  #
  #   ary = [1, 2, 3]
  #   Service.new.s_map(ary) #=> ["1", "2", "3"]
  #   Service.new.m_map(ary) #=> [2, 4, 6]
  def import(*aliases)
    container.import(*aliases)
  end

  # A placeholder that helps to use not positioned currying
  def _
    PLACEHOLDER
  end
end

F = FunRuby
