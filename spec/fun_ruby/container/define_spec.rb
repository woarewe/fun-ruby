# frozen_string_literal: true

require_lib "fun_ruby/container/define"

describe FunRuby::Container::Define do
  it "defines top-level functions" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function1 = ->(x, y) { x + y }
    function2 = ->(x, y) { x * y }

    define.() do
      f("fun1") { function1 }
      f("fun2") { function2 }
    end

    expect(container.fetch("fun1")).to be(function1)
    expect(container.fetch("fun2")).to be(function2)
  end

  it "defines functions under a single-level namespace" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function1 = ->(x, y) { x + y }
    function2 = ->(x, y) { x * y }

    define.() do
      namespace :math do
        f("fun1") { function1 }
        f("fun2") { function2 }
      end
    end

    expect(container.fetch("math.fun1")).to be(function1)
    expect(container.fetch("math.fun2")).to be(function2)
  end

  it "defines functions under a two-level namespace" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function1 = ->(x, y) { x + y }
    function2 = ->(x, y) { x * y }

    define.() do
      namespace :app do
        namespace :math do
          f("fun1") { function1 }
          f("fun2") { function2 }
        end
      end
    end

    expect(container.fetch("app.math.fun1")).to be(function1)
    expect(container.fetch("app.math.fun2")).to be(function2)
  end

  it "defines functions under different namespaces" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function1 = ->(x, y) { x + y }
    function2 = ->(x, y) { x * y }

    define.() do
      namespace :app do
        namespace :math do
          f("fun1") { function1 }
        end
      end

      namespace :lib do
        namespace :math do
          f("fun2") { function2 }
        end
      end
    end

    expect(container.fetch("app.math.fun1")).to be(function1)
    expect(container.fetch("lib.math.fun2")).to be(function2)
  end

  it "defines a function using a reference to not yet defined function" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function = ->(x, y) { x + y }

    define.() do
      namespace :app do
        namespace :math do
          f("fun1") { f("lib.math.fun2") }
        end
      end

      namespace :lib do
        namespace :math do
          f("fun2") { function }
        end
      end
    end

    expect(container.fetch("app.math.fun1")).to be(function)
    expect(container.fetch("lib.math.fun2")).to be(function)
  end

  it "defines a function using a short reference inside a namespace" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function = ->(x, y) { x + y }

    define.() do
      namespace :app do
        namespace :math do
          f("fun1") { f("fun2") }
          f("fun2") { function }
        end
      end
    end

    expect(container.fetch("app.math.fun1")).to be(function)
    expect(container.fetch("app.math.fun2")).to be(function)
  end

  it "defines a function using a short reference to a parent namespace function" do
    container = FunRuby::Container.new
    define = described_class.build(container: container)
    function = ->(x, y) { x + y }

    define.() do
      namespace :app do
        f("fun1") { function }
        namespace :math do
          f("fun2") { f("fun1") }
        end
      end
    end

    expect(container.fetch("app.fun1")).to be(function)
    expect(container.fetch("app.math.fun2")).to be(function)
  end
end
