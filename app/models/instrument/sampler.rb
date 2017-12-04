class Sampler < Audio

	attr_accessor :scripts, :mappings

	def initialize(mappings)
		@mappings = mappings
		to_string = mappings.map{|key, file_path| "'" + key.to_s + "': '" + file_path.to_s + "'"}.join(",")
		@scripts = ["var #{identifier} = new Tone.Sampler({
				#{to_string}
			});"]
	end

	def identifier
  	"sampler_" + object_id.to_s
  end
end
