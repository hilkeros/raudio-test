class NxButton < Nexus

	attr_accessor :scripts

	def initialize(event: 'console')
		@event = event
		@scripts = ["#{identifier}.on('*',function(data) {
            if(data.press==1){
              console.log(data);
              #{@event}
            }
          })"

		]
	end

	def identifier
		"button_" + object_id.to_s
	end

end
