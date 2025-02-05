#!/usr/bin/env ruby
# frozen_string_literal: true

module Scraby
  module Worker
    # A class to manage workers.
    class Manager
      # A manager worker that manage collecting terms.
      #
      # Define a class that inherits this class. Override {#run} by
      # implementing it in the class.

      # @param url [String] the URL of the web page. This page is the starting
      # point of the scraping process.
      def initialize(url)
        @url = url
      end

      # The method user defined class must implement.
      #
      # @raise [NotImplemented] when the method is not overridden.
      def run!
        raise NotImplementedError
      end

      def url
        @url.to_s
      end
    end
  end
end
