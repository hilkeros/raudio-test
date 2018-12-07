class Distortion < Effect

	attr_accessor :scripts, :distortion, :oversample

	def initialize(distortion = 0.4, oversample = 'none')
		@distortion = distortion
		@oversample = oversample
		@scripts = ["var #{identifier} = new Tone.Distortion(#{@distortion}, '#{@oversample}');"]
	end

	def identifier
		"distortion_" + object_id.to_s
	end
end
