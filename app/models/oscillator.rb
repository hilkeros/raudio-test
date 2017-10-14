class Oscillator < Audio

	attr_accessor :scripts, :frequency, :volume

	def initialize(frequency: 440, volume: 0)
    @frequency = frequency
    @volume = volume
    @scripts = ["var #{identifier} = new Tone.Oscillator({
      		'frequency' : #{@frequency},
      		'volume' : #{@volume}
    		});"]
  end

  def identifier
  	"osc_" + object_id.to_s
  end

end
