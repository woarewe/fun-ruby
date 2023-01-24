# frozen_string_literal: true

module FunRuby
  module Modules
    # Module containing methods for files
    module File
      include Common::Helpers

      extend self

      # Writes a given content to a given file
      #
      # @since 0.1.0
      #
      # @param filepath [::String]
      # @param content [::String]
      #
      # @example Basics
      #   tmp = Tempfile.new("file.txt")
      #   F::Modules::File.write(tmp.path, "abc")
      #   File.read(tmp.path) #=> "abc"
      #   tmp.unlink
      def write(filepath = F._, content = F._)
        curry_implementation(:write, filepath, content)
      end

      private

      def _write(filepath, content)
        ::File.open(filepath, "w") { |file| file.write(content) }
      end
    end
  end
end
