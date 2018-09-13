class PolySynth < Audio

	attr_accessor :scripts

	def initialize()
    @scripts = ["var #{identifier} = new Tone.PolySynth(6, Tone.AMSynth
    		);"]
  end

  def identifier
  	"poly_synth_" + object_id.to_s
  end

end