class Audio


	def to_master
  	@scripts << "#{identifier}.toMaster();"
  end

  def connect(destination)
  	@scripts << "#{identifier}.connect(#{destination.identifier});"
  end

  def start
  	script = "#{identifier}.start();
  	Tone.Transport.start('+0.1')"
  end

  def stop
  	script = "
  	Tone.Transport.stop();"
  end

  def trigger_attack(*args)
  	to_string = args.map{|arg| "'" + arg.to_s + "'"}.join(",")
  	script = "#{identifier}.triggerAttack(#{to_string});"
  	@scripts << script
  	return script
  end

  def trigger_attack_release(*args)
  	to_string = args.map{|arg| "'" + arg.to_s + "'"}.join(",")
  	script = "#{identifier}.triggerAttackRelease(#{to_string});"
  	#@scripts << script
  	return script
  end

  def render(*nodes)
  	script = []
  	nodes.each do |node|
  		script << node.scripts
  	end
		return ("<script id='ToneCode'>" + script.join("\n") +	"</script>").html_safe
  end

end
