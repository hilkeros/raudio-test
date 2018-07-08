class Ableton::PartsList < Audio

	attr_accessor :scripts

	def initialize(parts)
		part_identifiers = parts.map{|p| p.identifier}.join(', ')
		@scripts = ["var #{identifier} = [#{part_identifiers}]"]
	end

	def start_scene
		script = "start_scene(#{self.identifier})"
	end

	def identifier
			"partslist_" + object_id.to_s
	end

end