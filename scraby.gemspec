# frozen_string_literal: true

require_relative "lib/scraby/version"

Gem::Specification.new do |spec|
  spec.name = "scraby"
  spec.version = Scraby::VERSION
  spec.authors = ["Tomoyuki Sakurai"]
  spec.email = ["y@trombik.org"]

  spec.summary = "A ruby gem to help scrape terminologies on the Web."
  spec.description = "The gem let you focus on scraping terms and descriptions."
  spec.homepage = "https://github.com/trombik/scraby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/trombik/scraby"
  spec.metadata["changelog_uri"] = "https://github.com/trombik/scraby/releases"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = ""
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.18.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
