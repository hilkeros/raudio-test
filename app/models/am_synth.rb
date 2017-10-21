class AMSynth < Audio

	attr_accessor :scripts

	def initialize()
    @scripts = ["var #{identifier} = new Tone.AMSynth({
    		});"]
  end

  def identifier
  	"am_synth_" + object_id.to_s
  end

end
