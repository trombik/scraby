# frozen_string_literal: true

require "scraby/worker/base"
require "open-uri"

RSpec.describe Scraby::Worker::Base do

  let(:worker) { described_class.new }
  let(:test_file) { Pathname.new(File.expand_path(__FILE__)).parent.parent.parent / "data" / "test.html" }

  describe "#new" do
    it "does not throw" do
      expect { worker }.not_to raise_error
    end
  end

  describe "#date" do
    it "returns today" do
      expect(worker.date).to eq Date.today
    end
  end

  describe "#wait" do
    it "waits a few second" do
      expect(worker.wait.class).to eq Integer
    end
  end

  describe "#fetch" do

    it "reads a local file" do
      expect(worker.fetch(test_file.to_s).html.class).to eq String
    end

    context "when @url is nil and arg is nil" do
      it "raises Scraby::Worker::Error::UndefinedURL" do
        arg = nil
        expect { worker.fetch(arg) }.to raise_error Scraby::Worker::Error::UndefinedURL
      end
    end
  end

  describe "#parse" do
    context "when an HTML document has been read" do
      it "parses it with Nokogiri" do
        worker.fetch(test_file.to_s)
        expect(worker.parse.doc.class).to eq Nokogiri::HTML4::Document
      end
    end

    context "when no HTML document has been read" do
      it "raises an exception" do
        expect { worker.parse }.to raise_error Scraby::Worker::Error::NoHTMLFound
      end
    end
  end

  describe "#title" do
    context "when with a document" do
      it "returns the title element in text" do
        worker.fetch(test_file.to_s).parse
        expect(worker.title).to eq "Title"
      end
    end

    context "when without a document" do
      it "returns an empty string" do
        expect(worker.title).to eq ""
      end
    end
  end

  describe "#source_name" do
    context "when a source name is given" do
      it "returns the given source name" do
        worker = Scraby::Worker::Base.new(source_name: "Foo")
        expect(worker.fetch(test_file.to_s).parse.source_name).to eq "Foo"
      end
    end

    context "when a source name is not given" do
      it "returns <title> in text" do
        expect(worker.fetch(test_file.to_s).parse.source_name).to eq "Title"
      end
    end
  end
end
