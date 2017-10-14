class Audio


	def to_master
  	@scripts << "#{identifier}.toMaster();"
  end

  def start
  	@scripts << "#{identifier}.start();"
  end

  def render(*nodes)
  	script = []
  	nodes.each do |node|
  		script << node.scripts
  	end
		return ("<script id='ToneCode'>" + script.join("\n") +	"</script>").html_safe
  end

end
