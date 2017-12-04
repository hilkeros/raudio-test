class Distortion < Audio

	attr_accessor :scripts

	def initialize()
		@scripts = ["var #{identifier} = new Tone.Distortion();"]
	end

	def identifier
		"distortion_" + object_id.to_s
	end
end
