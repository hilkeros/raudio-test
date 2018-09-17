class ScrollY
	attr_accessor :scripts

	def initialize(condition, *events)
		js_condition = 'window.pageYOffset' + condition
		@scripts = "if(#{js_condition} && #{identifier} == 0) {
		    	 #{identifier} = 1;
		    	 #{events.join(';')}
		    }"
	end

	def identifier
		"scroll_" + object_id.to_s
	end

end