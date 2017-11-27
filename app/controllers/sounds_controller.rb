class SoundsController < ApplicationController
  def sine
  	@synth = MonoSynth.new
  	@synth.to_master
  	@loop = Loop.new(@synth.trigger_attack_release('A6', '1n'), '2n')
  	@loop.start
=begin
  	@sol = MonoSynth.new
  	@sol.to_master
  	@sol.triggerAttackRelease("G#5", "2")
=end
  	@raudio = Audio.new.render(@synth, @loop)
  end

  def sampler
  	@sampler = Sampler.new(
  		'C1': '/samples/lex/clap.wav',
  		'D1': '/samples/lex/snare.wav'
  		)
  	@sampler.to_master
  	@button1 = NxButton.new(event: @sampler.trigger_attack('C1'))
  	@button2 = NxButton.new(event: @sampler.trigger_attack('D1'))
  	@raudio = Audio.new.render(@sampler)
  	@nexus = Nexus.new.render(@button1, @button2)
  end
end
