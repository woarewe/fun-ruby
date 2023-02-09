# frozen_string_literal: true

require "active_support/core_ext/string"
require "erb"

require_relative "config"

module Tooling
  module Generators
    module Module
      TEMPLATE_PATH = File.expand_path("./templates/module.rb.erb", __dir__)

      module_function

      def call(module_name)
        file_path = file_path(module_name)
        file_content = render_template(module_name)
        create_file(file_path, file_content)
        require_module(module_name)
      end

      def render_template(module_name)
        binding = empty_binding
        binding.local_variable_set(:underscored_name, module_name.underscore)
        binding.local_variable_set(:camelized_name, module_name.camelize)
        template = ERB.new(File.read(TEMPLATE_PATH))
        template.result(binding)
      end

      def file_path(module_name)
        file_name = "#{module_name.underscore}.rb"
        full_path = File.expand_path(file_name, Config::MODULES_DIR)
        raise "The module FunRuby::Modules::#{module_name.camelize} already exists" if File.exists?(full_path)

        full_path
      end

      def create_file(path, content)
        File.open(path, "w") { |f| f.write(content) }
      end

      def require_module(module_name)
        content = File.read(Config::MODULES_FILE).strip
        content << <<~RUBY

          require_relative "modules/#{module_name.underscore}"
        RUBY
        File.open(Config::MODULES_FILE, "w") { |f| f.write(content) }
      end

      def empty_binding
        binding
      end
    end
  end
end
