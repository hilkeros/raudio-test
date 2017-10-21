class MonoSynth < Audio

	attr_accessor :scripts

	def initialize(
		frequency: 'C4',
		detune: 0,
		oscillator: { type: 'square'},
		filter: {
			Q: 6,
			type: 'lowpass',
			rolloff: -24
		}
	)
		@frequency = frequency
		@detune = detune
		@oscillator = oscillator
		@filter = filter

    @scripts = ["var #{identifier} = new Tone.MonoSynth({
    			'frequency': 		'#{@frequency}',
    			'detune': 			'#{@detune}',
    			'filter': 			'#{@filter}'
    		});"]
  end

  def identifier
  	"mono_synth_" + object_id.to_s
  end

end
