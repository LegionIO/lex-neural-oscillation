# lex-neural-oscillation

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-neural-oscillation`
- **Version**: 0.1.0
- **Namespace**: `Legion::Extensions::NeuralOscillation`

## Purpose

Brain rhythm coordination for the cognitive architecture. Models a network of oscillators with five canonical frequency bands (delta, theta, alpha, beta, gamma), bidirectional couplings between oscillators, synchronized phase propagation, and band-to-cognitive-state mapping. Informs processing mode based on dominant rhythm.

## Gem Info

- **Gemspec**: `lex-neural-oscillation.gemspec`
- **Homepage**: https://github.com/LegionIO/lex-neural-oscillation
- **License**: MIT
- **Ruby**: >= 3.4

## File Structure

```
lib/legion/extensions/neural_oscillation/
  version.rb
  client.rb
  helpers/
    constants.rb              # All constants — bands, cognitive states, power/coupling thresholds
    oscillator.rb             # Oscillator class — per-band power + phase tracking
    coupling.rb               # Coupling class — bidirectional oscillator link with strength
    oscillation_network.rb    # OscillationNetwork — store, propagation, global rhythm, tick
  runners/
    neural_oscillation.rb     # Runner module
  actors/
    tick.rb                   # Every-N actor driving update_neural_oscillations
spec/
  helpers/oscillator_spec.rb
  helpers/coupling_spec.rb
  helpers/oscillation_network_spec.rb
  runners/neural_oscillation_spec.rb
  client_spec.rb
```

## Key Constants

From `Helpers::Constants`:
- `BANDS = %i[delta theta alpha beta gamma]`
- `MAX_OSCILLATORS = 20`, `MAX_COUPLINGS = 100`, `MAX_HISTORY = 200`
- `POWER_DECAY = 0.02`, `DEFAULT_POWER = 0.3`, `DOMINANT_THRESHOLD = 0.5`
- `COUPLING_DECAY = 0.01`, `COUPLING_BOOST = 0.1`, `SYNC_THRESHOLD = 0.4`
- `PHASE_INCREMENT = 0.2`
- `COGNITIVE_STATES`: `delta: :unconscious`, `theta: :encoding`, `alpha: :resting`, `beta: :focused`, `gamma: :integrating`
- `BAND_INFO`: Hz ranges and cognitive role descriptions for each band

## Runners

| Method | Key Parameters | Returns |
|---|---|---|
| `add_oscillator` | `id:`, `domain:` | `{ oscillator: osc.to_h }` or `{ reason: :limit_reached }` |
| `activate_band` | `oscillator_id:`, `band:`, `amount:` | `{ oscillator: osc.to_h }` |
| `suppress_band` | `oscillator_id:`, `band:`, `amount:` | `{ oscillator: osc.to_h }` |
| `couple_oscillators` | `oscillator_a:`, `oscillator_b:`, `band:` | `{ coupling: c.to_h }` |
| `decouple_oscillators` | `oscillator_a:`, `oscillator_b:`, `band:` | `{ success: bool }` |
| `global_rhythm` | — | `{ rhythm:, cognitive_state:, synchrony: }` |
| `synchrony_for_band` | `band:` | `{ band:, synchrony: }` |
| `desynchronize_band` | `band:` | `{ band: }` |
| `update_neural_oscillations` | — | tick: advance phases, decay powers, cull weak couplings |
| `neural_oscillation_stats` | — | `{ stats: network.to_h }` |

## Helpers

### `Helpers::Oscillator`
Per-oscillator state: `@powers` hash (band -> float 0–1), `@phases` hash (band -> radians, random init). `activate/suppress` clamp power. `advance_phase` increments active bands at band-specific speed (`BAND_SPEEDS`). `synchrony_with(other, band:)` = 1 - normalized phase difference. `decay` reduces all powers by `POWER_DECAY`.

### `Helpers::Coupling` (inferred from network usage)
Links two oscillators on a specific band. Has `strength`, `synchronized?` (strength >= `SYNC_THRESHOLD`), `strengthen`, `decay`, `weak?`, `involves?(id)`, `partner_of(id)`, `key`.

### `Helpers::OscillationNetwork`
Main store. `activate_band` propagates activation to coupled partners at `amount * coupling.strength * 0.3`. `global_rhythm` returns the band with highest aggregate power across all oscillators. `cognitive_state` maps global rhythm to `COGNITIVE_STATES`. `tick` advances all phases, decays all powers, culls weak couplings, records history snapshot.

## Integration Points

- `global_rhythm` and `cognitive_state` can influence `lex-tick` mode selection
- `activate_band(:gamma)` could be triggered when `lex-phenomenal-binding` reports high coherence
- `activate_band(:theta)` aligns with `lex-memory` encoding operations
- `desynchronize_band` maps conceptually to `lex-conflict` disruption events
- `update_neural_oscillations` is the tick method called by the `Tick` actor

## Development Notes

- Phase initialization is random (`rand * 2 * Math::PI`) per oscillator per band
- Activation propagates one hop via coupled oscillators at `0.3 * coupling_strength * amount` (not recursive)
- `decouple` uses a sorted key `[[osc_a, osc_b].sort, band].flatten` for bidirectional lookup
- `desynchronize` halves coupling strength and suppresses each oscillator by 0.1
- State is fully in-memory; reset on process restart
