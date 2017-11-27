class Nexus

	def render(*items)
		script = []
		items.each do |item|
			script << item.scripts
		end
	end

end
