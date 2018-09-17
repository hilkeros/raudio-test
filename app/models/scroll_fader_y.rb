class ScrollFaderY
	attr_accessor :scripts

	def initialize(start_position = 0, node, parameter, math)
		@node = node.identifier
		js_condition = 'window.pageYOffset >' + start_position.to_s
		@scripts = "if(#{js_condition}) {
		    	 #{@node}.#{parameter}.value = window.pageYOffset #{math};
		    }"
	end

	def identifier
		"scroll_fader_" + object_id.to_s
	end
end