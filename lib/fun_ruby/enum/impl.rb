module FunRuby
  module Enum
    module Impl
      class << self
        def each(function, collection)
          enum(collection).each(&function)
        end

        def map(function, collection)
          enum(collection).map(&function)
        end

        private

        def enum(collection)
          collection.to_enum
        end
      end
    end
  end
end
