#!/usr/bin/env ruby
# frozen_string_literal: true

require "scraby"

class MyWorker < Scraby::Worker::SinglePage
  def collect
    terms = []
    doc.css("p.word1").each do |word|
      english = ""
      description = word.next_element.text
      if description =~ /英文：([a-zA-Z0-9\- ]+)/
        english = Regexp.last_match[1]
        description.gsub!(/英文：[a-zA-Z0-9\- ]+/, "")
      end
      term = {
        name: word.text,
        description: description,
        english: english
      }
      terms << term
    end
    terms
  end
end

class MyManager < Scraby::Worker::Manager
  def run!
    worker = MyWorker.new
    worker.fetch(url).parse
    source_name = worker.title
    source_url = url
    genres = ["manufacturing"]

    terms = worker.collect
    terms.map do |term|
      term[:source_url] = source_url
      term[:source_name] = source_name
      term[:genres] = genres
    end
    terms
  end
end

manager = MyManager.new("https://www.daikodenshi.jp/solution/rbom/term-a/")
puts manager.run!.to_json
