# lex-neural-oscillation

Brain rhythm coordination for the LegionIO cognitive architecture. Models oscillator networks with frequency bands, phase synchronization, and cognitive state inference.

## What It Does

Maintains a network of named oscillators, each tracking power and phase across five canonical frequency bands (delta, theta, alpha, beta, gamma). Oscillators can be coupled so activation spreads between them. The dominant band across the network determines a cognitive state: `:encoding` (theta), `:focused` (beta), `:integrating` (gamma), etc. Useful for coordinating processing mode across cognitive subsystems.

## Usage

```ruby
client = Legion::Extensions::NeuralOscillation::Client.new

# Add oscillators for different cognitive processes
client.add_oscillator(id: :working_memory, domain: :cognition)
client.add_oscillator(id: :attention, domain: :cognition)

# Couple them on the gamma band (feature binding)
client.couple_oscillators(
  oscillator_a: :working_memory,
  oscillator_b: :attention,
  band: :gamma
)

# Activate a band
client.activate_band(oscillator_id: :attention, band: :beta, amount: 0.4)

# Check global state
client.global_rhythm
# => { rhythm: :beta, cognitive_state: :focused, synchrony: 0.72 }

# Advance one tick (decay + phase advancement)
client.update_neural_oscillations

# Full stats
client.neural_oscillation_stats
```

## Frequency Bands

| Band | Hz Range | Cognitive Role |
|---|---|---|
| delta | 0.5–4 Hz | Deep sleep, unconscious processing |
| theta | 4–8 Hz | Memory encoding, spatial navigation |
| alpha | 8–13 Hz | Relaxed awareness, idle inhibition |
| beta | 13–30 Hz | Active thinking, motor planning |
| gamma | 30–100 Hz | Feature binding, consciousness |

## Cognitive States

`delta: :unconscious`, `theta: :encoding`, `alpha: :resting`, `beta: :focused`, `gamma: :integrating`

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
