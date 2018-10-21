class NxButton < Nexus

	attr_accessor :scripts

	def initialize(*events)
		@scripts = ["var #{identifier} = new Nexus.Button('##{identifier}');
			#{identifier}.on('change',function(v) {
            if(v.state === true){
              #{events.join(';')}
            }
          })"

		]
	end

	def identifier
		"button_" + object_id.to_s
	end

end
