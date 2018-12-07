class JCReverb < Effect
	attr_accessor :roomSize, :dampening, :scripts

	def initialize(roomSize = 0.5)
		@roomSize = roomSize
		@scripts = ["var #{identifier} = new Tone.JCReverb(
									'#{@roomSize}');"]
	end

	def identifier
		"jc_reverb_" + object_id.to_s
	end


end
