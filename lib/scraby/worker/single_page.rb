# frozen_string_literal: true

require "scraby/worker/base"

module Scraby
  module Worker
    # A worker to parse a single page.
    class SinglePage < Base
      def collect
        raise NotImplementedError, "The method must be overriden by the inherited class"
      end
    end
  end
end
