class MonoSynth < Audio

	attr_accessor :frequency, :detune, :oscillator, :filter, :envelope, :filterEnvelope, :scripts

	def initialize(
		frequency: 'C4',
		detune: 0,
		oscillator: { type: 'square'},
		filter: {
			Q: 6,
			type: 'lowpass',
			rolloff: -24
		},
		envelope: {
			attack: 0.005,
			decay: 0.1,
			sustain: 0.9,
			release: 1
		},
		filter_envelope: {
			attack: 0.06,
			decay: 0.2,
			sustain: 0.5,
			release: 2,
			base_frequency: 200,
			octaves: 7,
			exponent: 2
		}
	)
		@frequency = frequency
		@detune = detune
		@oscillator = oscillator
		@filter = filter
		@envelope = envelope
		@filter_envelope = filter_envelope

    @scripts = ["var #{identifier} = new Tone.MonoSynth({
    			'frequency': 		'#{@frequency}',
    			'detune': 			'#{@detune}',
					'oscillator': 	{'type': '#{@oscillator[:type]}'},
    			'filter': 			{
							            'Q': '#{@filter[:Q]}',
							            'type': '#{@filter[:type]}',
							            'rolloff': '#{@filter[:rolloff]}'
							          	},
        	'envelope': 		{
        									'attack': '#{@envelope[:attack]}',
        									'decay': '#{@envelope[:decay]}',
        									'sustain': '#{@envelope[:sustain]}',
        									'release': '#{@envelope[:release]}'
        									},
					'filterEnvelope': {
													'attack': '#{@filter_envelope[:attack]}',
													'decay': '#{@filter_envelope[:decay]}',
													'sustain': '#{@filter_envelope[:sustain]}',
													'release': '#{@filter_envelope[:release]}',
													'decay': '#{@filter_envelope[:decay]}',
													'baseFrequency': '#{@filter_envelope[:base_frequency]}',
													'octaves': '#{@filter_envelope[:octaves]}',
													'exponent': '#{@filter_envelope[:exponent]}'
												}
    		});"]
  end

  def identifier
  	"mono_synth_" + object_id.to_s
  end

end
