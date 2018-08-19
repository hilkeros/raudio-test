class Audio


	def initialize(bpm: 120)
    @bpm = bpm
  end


  def to_master
  	@scripts << "#{identifier}.toMaster();"
  end

  def connect(destination)
  	@scripts << "#{identifier}.connect(#{destination.identifier});"
  end

  def start(offset = nil )
  	if offset.blank?
      script = "#{identifier}.start();"
    else
       script = "#{identifier}.start('#{offset}');"
    end
  end

  def stop
    script = "#{identifier}.stop();"
  end

  def stop_all
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
  	script = ["Tone.Transport.bpm.value = #{@bpm}; Tone.Transport.start();"]
  	nodes.each do |node|
  		script << node.scripts
  	end
		return ("<script id='ToneCode'>" + script.join("\n") +	"</script>").html_safe
  end

end
