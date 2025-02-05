# frozen_string_literal: true

require "scraby/worker/manager"

class MyManager < Scraby::Worker::Manager
  def run!
  end
end

class MyFailedManager < Scraby::Worker::Manager
end

RSpec.describe Scraby::Worker::Manager do

  let(:worker) { MyManager.new(test_file) }
  let(:worker_without_run_undefined) { MyFailedManager.new(test_file) }
  let(:test_file) { Pathname.new(File.expand_path(__FILE__)).parent.parent.parent / "data" / "test.html" }

  describe "#url" do
    it "returns URL" do
      expect(worker.url).to eq test_file.to_s
    end
  end
  describe "#run!" do
    context "when #run! method is defined by user" do
      it "does not throw" do
        expect { worker.run! }.not_to raise_error
      end
    end

    context "when #run method id not defined by user" do
      it "throws NotImplemented" do
        expect { worker_without_run_undefined.run! }.to raise_error NotImplementedError
      end
    end
  end
end
