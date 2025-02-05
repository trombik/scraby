# frozen_string_literal: true

require "scraby/worker/base"

module Scraby
  module Worker
    class SinglePage < Base

      def collect
        raise NotImplementedError, "The method must be overriden by the inherited class"
      end
    end
  end
end
