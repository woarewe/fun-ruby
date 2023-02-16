# frozen_string_literal: true

TEST_CONTAINER.define do
  namespace :hello do
    f(:word) { -> { "Hello, world!" } }
  end
end
