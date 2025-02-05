# frozen_string_literal: true

require "scraby/worker/base"

module Scraby
  module Worker
    # A worker tp find a link to next page.
    class LinkFinder < Base
      def collect
        raise NotImplementedError
      end
    end
  end
end
