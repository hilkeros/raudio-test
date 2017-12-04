class NxButton < Nexus

	attr_accessor :scripts

	def initialize(*events)
		@scripts = ["#{identifier}.on('*',function(data) {
            if(data.press==1){
              console.log(data);
              #{events.join(';')}
            }
          })"

		]
	end

	def identifier
		"button_" + object_id.to_s
	end

end
