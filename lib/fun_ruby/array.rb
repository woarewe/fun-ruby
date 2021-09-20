module FunRuby
  module Array
    module_function

    def each(function = nil, collection = nil)
      curried = method(:each_impl).curry
    end

    private

    def each_impl(function, collection)
      collection.to_enum.each(&func)
    end
  end
end
