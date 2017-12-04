class Loop < Audio

	attr_accessor :event, :interval, :scripts
	def initialize(event, interval = '4n')
		@event = event
		@interval = interval

		@scripts = ["var #{identifier} = new Tone.Loop(function(time){
							#{@event}}, '#{@interval}')
				"]
	end

	def identifier
		"loop_" + object_id.to_s
	end

end
