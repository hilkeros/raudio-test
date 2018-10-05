class ScrollFaderX
	attr_accessor :scripts

	def initialize(start_position = 0, node, parameter, math)
		@node = node.identifier
		js_condition = 'window.pageXOffset >' + start_position.to_s
		@scripts = "if(#{js_condition}) {
		    	 #{@node}.#{parameter} = window.pageXOffset #{math};
		    }"
	end

	def identifier
		"scroll_fader_" + object_id.to_s
	end
end