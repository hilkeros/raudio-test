class NxDial < Nexus

	attr_accessor :scripts

	def initialize(node, parameter, options = {})
		if node.is_a? String
			@node = node
		else
			@node = node.identifier
		end
		@scripts = ["var #{identifier} = new Nexus.Dial('##{identifier}', #{options.to_json} );
			var number_#{identifier} = new Nexus.Number('#number_#{identifier}');
			number_#{identifier}.link(#{identifier});
			#{identifier}.on('change',function(v) {
           #{@node}.#{parameter}.value = v
          })"
		]
	end

	def identifier
		"dial_" + object_id.to_s
	end

end
