# frozen_string_literal: true

require "scraby/worker/base"

module Scraby
  module Worker
    class LinkFinder < Base
      def collect
        raise NotImplementedError
      end
    end
  end
end
