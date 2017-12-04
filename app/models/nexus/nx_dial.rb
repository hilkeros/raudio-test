class NxDial < Nexus

	attr_accessor :scripts

	def initialize(node, parameter)
		@node = node.identifier
		@scripts = ["#{identifier}.on('*',function(data) {
           #{@node}.#{parameter}.value = data.value
          })"
		]
	end

	def identifier
		"dial_" + object_id.to_s
	end

end
