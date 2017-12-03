class SoundsController < ApplicationController
  def sine
  	@synth = MonoSynth.new
  	@synth.to_master
  	@loop = Loop.new(@synth.trigger_attack_release('C3', '8n'), '2n')

  	@start_button = NxButton.new(event: @loop.start)
  	@stop_button = NxButton.new(event: @loop.stop)

  	@raudio = Audio.new.render(@synth, @loop)
  	@nexus = Nexus.new.render(@start_button, @stop_button)
  end

  def sampler
  	@sampler = Sampler.new(
  		'C1': '/samples/lex/clap.wav',
  		'D1': '/samples/lex/snare.wav',
  		'E1': '/samples/lex/gick.wav'
  		)
  	@sampler.to_master
  	@button1 = NxButton.new(event: @sampler.trigger_attack('C1'))
  	@button2 = NxButton.new(event: @sampler.trigger_attack('D1'))
  	@button3 = NxButton.new(event: @sampler.trigger_attack('E1'))
  	@raudio = Audio.new.render(@sampler)
  	@nexus = Nexus.new.render(@button1, @button2, @button3)
  end
end
