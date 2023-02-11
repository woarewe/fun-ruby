# frozen_string_literal: true

require_lib "fun_ruby/modules"

describe FunRuby::Modules::Array do
  describe ".first" do
    it "returns the first element of the array" do
      expect(described_class.first([1, 2, 3])).to eq(1)
      expect(described_class.first([])).to eq(nil)
    end

    it "can be curried" do
      curried = described_class.first
      expect(curried.([1, 2, 3])).to eq(1)
      expect(curried.([])).to eq(nil)
    end
  end

  describe ".last" do
    it "returns the last element of the array" do
      expect(described_class.last([1, 2, 3])).to eq(3)
      expect(described_class.last([])).to eq(nil)
    end

    it "can be curried" do
      curried = described_class.last
      expect(curried.([1, 2, 3])).to eq(3)
      expect(curried.([])).to eq(nil)
    end
  end
end
