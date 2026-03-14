# frozen_string_literal: true

require_relative 'lib/legion/extensions/neural_oscillation/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-neural-oscillation'
  spec.version       = Legion::Extensions::NeuralOscillation::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']
  spec.summary       = 'LegionIO neural oscillation extension'
  spec.description   = 'Brain rhythm coordination for LegionIO — theta, alpha, beta, gamma ' \
                       'oscillations synchronizing distributed cognitive processing'
  spec.homepage      = 'https://github.com/LegionIO/lex-neural-oscillation'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']           = spec.homepage
  spec.metadata['source_code_uri']        = spec.homepage
  spec.metadata['documentation_uri']      = "#{spec.homepage}/blob/master/README.md"
  spec.metadata['changelog_uri']          = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata['bug_tracker_uri']        = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required']  = 'true'

  spec.files         = Dir['lib/**/*', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']
end
