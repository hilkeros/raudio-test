class SoundsController < ApplicationController
  def sine
  	@synth = AMSynth.new
  	@synth.to_master
  	@synth.triggerAttackRelease("C#5", "2")

  	@sol = AMSynth.new
  	@sol.to_master
  	@sol.triggerAttackRelease("G#5", "2")

  	@raudio = Audio.new.render(@synth, @sol)
  end

  def sampler
  end
end
