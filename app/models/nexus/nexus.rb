class Nexus
	def render(*items)
		script = []
		items.each do |item|
			script << item.scripts
		end
		return ("<script id='NexusCode'> nx.onload = function() {" + script.join("\n") +
			"}</script>").html_safe
	end
end
