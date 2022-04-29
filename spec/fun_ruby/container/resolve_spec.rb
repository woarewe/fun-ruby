# frozen_string_literal: true

require_lib "fun_ruby/container"
require_lib "fun_ruby/container/resolve"

describe FunRuby::Container::Resolve do
  it "resolves top-level function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("key") { function }
    resolve = described_class.build(container: container)

    expect(resolve.("key")).to eq(function)
  end

  it "resolves a single-namespaced function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["namespace"])

    expect(resolve.("key")).to eq(function)
  end

  it "resolves a double-namespaced function" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace"])

    expect(resolve.("app.namespace.key")).to eq(function)
  end

  it "resolves a function under a fully-aliased namespace" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace" => "alias"])

    expect(resolve.("alias.key")).to be(function)
  end

  it "resolves a function under a partially-aliased namespace" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("root.app.namespace.key") { function }
    resolve = described_class.build(container: container, aliases: ["app.namespace" => "alias"])

    expect(resolve.("root.alias.key")).to be(function)
  end

  it "is able to resolve nils" do
    container = FunRuby::Container.new
    container.define("key") { nil }
    resolve = described_class.build(container: container)

    expect(resolve.("key")).to be(nil)
  end

  it "resolves an alias in the beginning" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("app.math.map") { function }
    resolve = described_class.build(container: container, aliases: ["app.math" => "m"])

    expect(resolve.("m.map")).to be(function)
  end

  it "resolves an alias in the middle" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("core.app.math.map") { function }
    resolve = described_class.build(container: container, aliases: ["app.math" => "m"])

    expect(resolve.("core.m.map")).to be(function)
  end

  it "resolves an alias in the end" do
    function = ->(x, y) { x + y }
    container = FunRuby::Container.new
    container.define("core.app.math") { function }
    resolve = described_class.build(container: container, aliases: ["app.math" => "m"])

    expect(resolve.("core.m")).to be(function)
  end
end
