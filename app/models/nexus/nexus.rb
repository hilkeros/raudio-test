class Nexus
	def render(*items)
		script = []
		items.each do |item|
			script << item.scripts
		end
		return ("<script id='NexusCode'>" + script.join("\n") +
			"</script>").html_safe
	end
end
