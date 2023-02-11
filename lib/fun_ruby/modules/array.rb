# frozen_string_literal: true

module FunRuby
  module Modules
    # Module containing methods for arrays
    module Array
      include Common::Helpers

      extend self

      private

      def _array(array)
        array.to_a
      end
    end
  end
end

require_relative "array/join"
require_relative "array/size"
require_relative "array/first"
require_relative "array/last"
