class Oscillator < Audio

	attr_accessor :type, :frequency, :detune, :phase, :volume, :scripts

	def initialize(type: 'sine', frequency: 440, detune: 0, phase: 0, volume: 0)
    @type = type #sine, triangle, sawtooth, square, custom
    @frequency = frequency
    @detune = detune
    @phase = phase
    @volume = volume

    @scripts = ["var #{identifier} = new Tone.Oscillator({
      		'type': 	 			'#{@type}',
      		'frequency' : 	#{@frequency},
      		'detune' : 			#{@detune},
      		'phase' : 			#{@phase},
      		'volume' : 			#{@volume}
    		});"]
  end

  def identifier
  	"osc_" + object_id.to_s
  end

end
