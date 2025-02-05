# frozen_string_literal: true

require "scraby/worker/link_finder"

class MyWorker < Scraby::Worker::LinkFinder
  def collect
    doc.css("ul > li > a").map do |a|
      a.attributes["href"].text
    end
  end
end

RSpec.describe Scraby::Worker::LinkFinder do
  let(:worker_not_implemented) { described_class.new }
  let(:worker) { MyWorker.new }
  let(:test_file) { Pathname.new(File.expand_path(__FILE__)).parent.parent.parent / "data" / "links.html" }
  let(:links) { ["a.html", "b.html"] }

  describe "#new" do
    it "dose not throw" do
      expect { worker }.not_to raise_error
    end
  end

  describe "#collect" do
    it "#collect" do
      expect(worker.fetch(test_file.to_s).parse.collect).to eq links
    end

    context "when the method is not defined by the user" do
      it "raises" do
        expect { worker_not_implemented.fetch(test_file.to_s).parse.collect }.to raise_error NotImplementedError
      end
    end
  end
end
