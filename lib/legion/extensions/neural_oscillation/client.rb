# frozen_string_literal: true

require 'legion/extensions/neural_oscillation/helpers/constants'
require 'legion/extensions/neural_oscillation/helpers/oscillator'
require 'legion/extensions/neural_oscillation/helpers/coupling'
require 'legion/extensions/neural_oscillation/helpers/oscillation_network'
require 'legion/extensions/neural_oscillation/runners/neural_oscillation'

module Legion
  module Extensions
    module NeuralOscillation
      class Client
        include Runners::NeuralOscillation

        def initialize(network: nil, **)
          @network = network || Helpers::OscillationNetwork.new
        end

        private

        attr_reader :network
      end
    end
  end
end
