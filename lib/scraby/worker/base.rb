#!/usr/bin/env ruby
# frozen_string_literal: true

require "open-uri"
require "nokogiri"
require "json"
require "date"

module Scraby
  module Worker
    class Error
      class UndefinedURL < StandardError
      end
      class NoHTMLFound < StandardError
      end
    end

    class Base

      include Scraby::Filter

      attr_accessor :date, :doc, :html
      def initialize(**args)
        @title = args[:title] || nil
        @date = Date.today
        @html = nil
        @doc = nil
        @source_name = args[:source_name] || nil
      end

      def wait(sec = 2)
        sec = sec + rand(3)
        sleep sec
        sec
      end

      def title
        if @doc
          @doc.at_css("title").text
        end
      end

      def fetch(arg)

        raise Scraby::Worker::Error::UndefinedURL if arg.nil?
        uri = URI.parse(arg)
        @html = if uri.scheme.nil?
          File.read(uri.to_s)
        else
          URI.parse(uri.to_s).open.read
        end
        self
      end

      def parse

        raise Scraby::Worker::Error::NoHTMLFound unless @html
        @doc = Nokogiri::HTML.parse(@html)
        self
      end

      def title
        if @doc
          @doc.at_css("title").text
        else
          ""
        end
      end

      def source_name
        if @source_name.nil?
          title
        else
          @source_name
        end
      end
    end
  end
end
