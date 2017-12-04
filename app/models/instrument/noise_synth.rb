class NoiseSynth < Audio

	attr_accessor :noise, :envelope, :scripts

	def initialize(
		noise: { type: 'white'},
		envelope: {
			attack: 0.005,
			decay: 0.1,
			sustain: 0.0
		}

	)
		@noise = noise
		@envelope = envelope
    @scripts = ["var #{identifier} = new Tone.NoiseSynth({
					'noise': 	{'type': '#{@noise[:type]}'},
        	'envelope': 		{
        									'attack': '#{@envelope[:attack]}',
        									'decay': '#{@envelope[:decay]}',
        									'sustain': '#{@envelope[:sustain]}'
        									}
    		});"]
  end

  def identifier
  	"noise_synth_" + object_id.to_s
  end

end
