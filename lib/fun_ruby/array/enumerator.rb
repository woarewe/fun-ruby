module FunRuby
  module Array
    class Enumerator
      def initialize(array)
        @enum = array.to_a.each
        @array = array
      end

      def each(&block)
        return self if block.nil?

        @enum.each(&block)
        @array
      end

      def map(&block)
        return self if block.nil?

        values = @enum.map(&block)
        @array.class.new(values)
      end

      def next
        @enum.next
      end
    end
  end
end
