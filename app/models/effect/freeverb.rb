class Freeverb < Effect
	attr_accessor :roomSize, :dampening, :scripts

	def initialize(roomSize = 0.7, dampening = 3000)
		@roomSize = roomSize
		@dampening = dampening
		@scripts = ["var #{identifier} = new Tone.Freeverb(
									'#{@roomSize}', #{@dampening});"]
	end

	def identifier
		"freeverb_" + object_id.to_s
	end


end
