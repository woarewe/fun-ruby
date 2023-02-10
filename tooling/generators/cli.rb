# frozen_string_literal: true

require_relative "module"
require "dry/cli"

module Tooling
  module Generators
    class CLI
      extend Dry::CLI::Registry

      class Module < Dry::CLI::Command
        desc "Generates a new module and enables it withing the library"

        argument :name, required: true, desc: "Module name without prefixes"

        def call(name:, **)
          name, path = Generators::Module.(name)
          puts "#{name} -> #{path}"
        end
      end

      register "module", Module
    end
  end
end
