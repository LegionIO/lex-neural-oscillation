# frozen_string_literal: true

module Legion
  module Extensions
    module NeuralOscillation
      module Actors
        class Tick < Legion::Extensions::Actors::Every
          INTERVAL = 5

          def run
            Runners::NeuralOscillation.instance_method(:update_neural_oscillations).bind_call(runner_instance)
          end
        end
      end
    end
  end
end
