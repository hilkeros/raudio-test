class NxToggle < Nexus

	attr_accessor :scripts

	def initialize(*events)
		@scripts = ["var #{identifier} = new Nexus.Toggle('##{identifier}');
			#{identifier}.on('change',function(v) {
              #{events.join(';')}
          })"
		]
	end

	def identifier
		"toggle_" + object_id.to_s
	end

end
