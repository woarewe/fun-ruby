module FunRuby
  module Enum
    class << self
      def each(function = nil, collection = nil)
        curried = Impl.method(:each).curry

        if function
          raise ArgumentError, "function has to respond to #call" unless function.respond_to?(:call)

          curried = curried.(function)
        end

        return curried if collection.nil?

        curried.(collection)
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

binding.irb
