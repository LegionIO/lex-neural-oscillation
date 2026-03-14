# frozen_string_literal: true

require 'legion/extensions/neural_oscillation/version'
require 'legion/extensions/neural_oscillation/helpers/constants'
require 'legion/extensions/neural_oscillation/helpers/oscillator'
require 'legion/extensions/neural_oscillation/helpers/coupling'
require 'legion/extensions/neural_oscillation/helpers/oscillation_network'
require 'legion/extensions/neural_oscillation/runners/neural_oscillation'
require 'legion/extensions/neural_oscillation/client'

module Legion
  module Extensions
    module NeuralOscillation
      extend Legion::Extensions::Core if Legion::Extensions.const_defined?(:Core)
    end
  end
end
