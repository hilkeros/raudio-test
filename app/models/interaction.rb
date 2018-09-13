class Interaction
	def render(*items)
		scripts = []
		fires = []
		items.each do |item|
			scripts << item.scripts
			fires << 'var ' + item.identifier + " = 0;"
		end
		return ("<script id='InteractionCode'>" + fires.join("\n") + 
			"function testScroll(ev){" + scripts.join("\n") +
			"}window.onscroll=testScroll</script>").html_safe
	end
end