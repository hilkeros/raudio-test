class SoundsController < ApplicationController
  def sine
  	@synth = MonoSynth.new
  	@synth.to_master
  	@synth2 = MonoSynth.new
  	@synth2.to_master
  	@loop = Loop.new(@synth.trigger_attack_release('C3', '8n'), '2n')
  	@loop2 = Loop.new(@synth2.trigger_attack_release('G4', '32n'), '8t')

  	@start_button = NxButton.new(@loop.start, @loop2.start)
  	@stop_button = NxButton.new(@loop.stop, @loop2.stop)

  	@raudio = Audio.new.render(@synth, @synth2, @loop, @loop2)
  	@nexus = Nexus.new.render(@start_button, @stop_button)
  end

  def sampler
  	@sampler = Sampler.new(
  		'C1': '/samples/lex/clap.wav',
  		'D1': '/samples/lex/snare.wav',
  		'E1': '/samples/lex/gick.wav'
  		)
  	@sampler.to_master
  	@button1 = NxButton.new(@sampler.trigger_attack('C1'))
  	@button2 = NxButton.new(@sampler.trigger_attack('D1'))
  	@button3 = NxButton.new(@sampler.trigger_attack('E1'))
  	@raudio = Audio.new.render(@sampler)
  	@nexus = Nexus.new.render(@button1, @button2, @button3)
  end

  def beat_loop
  	@sampler = Sampler.new(
  		'C1': '/samples/lex/clap.wav',
  		'D1': '/samples/lex/snare.wav',
  		'E1': '/samples/lex/gick.wav'
  		)
  	@delay = FeedbackDelay.new('8n', 0.5)
  	@sampler.connect(@delay)
  	@delay.to_master
  	@clap_loop = Loop.new(@sampler.trigger_attack('C1', '4n'), '2n')
  	@snare_loop = Loop.new(@sampler.trigger_attack('D1'), '8n')

  	@button1 = NxButton.new(@clap_loop.start)
  	@button2 = NxButton.new(@snare_loop.start)
  	@button3 = NxButton.new(@clap_loop.stop, @snare_loop.stop)
  	@dial1 = NxDial.new(@delay, 'delayTime')
  	@dial2 = NxDial.new(@delay, 'feedback')
  	@dial3 = NxDial.new(@delay, 'wet')

  	@raudio = Audio.new.render(@delay, @sampler, @clap_loop, @snare_loop)
  	@nexus = Nexus.new.render(@button1, @button2, @button3, @dial1, @dial2, @dial3)
  end

  def midi
  	@synth = AMSynth.new
  	@synth.to_master
  	@raudio = Audio.new.render(@synth)
  	@midi = Midi.new(@synth).script;
  end

  def ableton
    @synth = AMSynth.new
    @sampler = Sampler.new(
      'C1': '/samples/lex/clap.wav',
      'D1': '/samples/lex/snare.wav',
      'C#1': '/samples/lex/gick.wav'
      )
    @synth.to_master
    @sampler.to_master
    a = Ableton.new('two-tracks.xml')
    @track_1 = AbletonTrack.new(a.midi_tracks.first)
    @part_1 = Part.new(@synth, @track_1.events_array, true, @track_1.loop_end)
    @track_2 = AbletonTrack.new(a.midi_tracks.last)
    @part_2 = Part.new(@sampler, @track_2.events_array, true, @track_2.loop_end)
    @start_1_button = NxButton.new(@part_1.start)
    @start_2_button = NxButton.new(@part_2.start)
    @stop_1_button = NxButton.new(@part_1.stop)
    @stop_2_button = NxButton.new(@part_2.stop)
    @raudio = Audio.new.render(@synth, @sampler, @part_1, @part_2)
    @nexus = Nexus.new.render(@start_1_button, @stop_1_button, @start_2_button, @stop_2_button)

  end
end
