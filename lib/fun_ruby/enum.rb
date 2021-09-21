module FunRuby
  module Enum
    class << self
      def each(*args)
        Curried::Function.new(
          function: Enum::Impl.method(:each)
        ).call(*args)
      end

      def map(function = nil, collection = nil)

      end

      private


      def map_impl(function, collection)
        enum(collection)
      end

      def enum(collection)
        collection.to_enum
      end
    end
  end
end
