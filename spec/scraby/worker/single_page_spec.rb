# frozen_string_literal: true

require "scraby/worker/single_page"

class MySinglePageWorker < Scraby::Worker::SinglePage
  def collect
    terms = []
    self.doc.css("dl > dt").each do |dt|
      term = dt.text
      description = dt.next_element.text

      terms << {
        name: term,
        description: description,
      }
    end
    terms
  end
end

RSpec.describe Scraby::Worker::SinglePage do

  let(:worker_not_implemented) { described_class.new }
  let(:worker) { MySinglePageWorker.new }
  let(:test_file) { Pathname.new(File.expand_path(__FILE__)).parent.parent.parent / "data" / "test.html" }
  let(:test_file_with_issues) { Pathname.new(File.expand_path(__FILE__)).parent.parent.parent / "data" / "filters.html" }
  let(:first_term) {
    {
      name: "Foo",
      description: "Something"
    }
  }

  describe "#new" do
    it "does no throw" do
      expect { worker }.not_to raise_error
    end
  end

  describe "#collect" do
    context "when the method is not overriden" do
      it "throws NotImplementedError" do
        expect { worker_not_implemented.collect }.to raise_error NotImplementedError
      end
    end

    context "when the method is defined by user" do
      it "does not throw NotImplementedError" do
        expect { worker.fetch(test_file.to_s).parse.collect }.not_to raise_error
      end
    end

    context "when a document is parsed" do
      it "returns parsed terms" do
        expect(worker.fetch(test_file.to_s).parse.collect.class).to be Array
      end
    end

    context "when a document is parsed" do
      it "returns parsed terms and the first one is correct" do
        expect(worker.fetch(test_file.to_s).parse.collect.first).to eq first_term
      end
    end
  end

  describe "#replace_multiple_spaces" do
    context "when a text with multiple spaces is given" do

      it "filters the spaces with a single space" do
        term = worker.fetch(test_file_with_issues.to_s).parse.collect.first
        expect(worker.replace_multiple_spaces(term)).to eq({ name: "Foo multiple spaces", description: "Something multiple spaces " })
      end
    end

    context "when a text with multiple zenkaku spaces is given" do

      it "filters the spaces with a single space" do
        term = worker.fetch(test_file_with_issues.to_s).parse.collect[1]
        expect(worker.replace_multiple_spaces(term)[:name]).to eq("Bar zenkaku spaces")
      end
    end
  end

  describe "#strip_newlines" do
    it "strip all the newlines" do
      term = worker.fetch(test_file_with_issues.to_s).parse.collect[1]
      expect(worker.strip_newlines(term)[:description]).to match(/^Something else\s+newline\s+$/)
    end
  end
end
