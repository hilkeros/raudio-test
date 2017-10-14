class Oscillator

	attr_accessor :scripts, :frequency, :volume

	def initialize(frequency: 440, volume: 0)
    @frequency = frequency
    @volume = volume
    @scripts = ["var #{self.identifier} = new Tone.Oscillator({
      		'frequency' : #{@frequency},
      		'volume' : #{@volume}
    		});"]
  end

  def identifier
  	"osc_" + object_id.to_s
  end

	def render
		("<script id='ToneCode'>" + self.scripts.join("\n") +	"</script>").html_safe
  end



  def to_master
  	script = "#{self.identifier}.toMaster();"
  	@scripts << script
  end

  def start
  	script = "#{self.identifier}.start();"
  	@scripts << script
  end


end
