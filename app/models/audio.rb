class Audio


	def to_master
  	@scripts << "#{identifier}.toMaster();"
  end

  def start
  	@scripts << "#{identifier}.start();"
  end

  def trigger_attack(*args)
  	to_string = args.map{|arg| "'" + arg.to_s + "'"}.join(",")
  	script = "#{identifier}.triggerAttack(#{to_string});"
  	@scripts << script
  	return script
  end

  def trigger_attack_release(*args)
  	to_string = args.map{|arg| "'" + arg.to_s + "'"}.join(",")
  	@scripts << "#{identifier}.triggerAttackRelease(#{to_string});"
  end

  def render(*nodes)
  	script = []
  	nodes.each do |node|
  		script << node.scripts
  	end
		return ("<script id='ToneCode'>" + script.join("\n") +	"</script>").html_safe
  end

end
