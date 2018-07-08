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
    clip_1 = a.midi_tracks.first.clip_slots.first
    @part_1 = clip_1.build_part(@synth)
    clip_2 = a.midi_tracks.last.clip_slots.first
    @part_2 = clip_2.build_part(@sampler)

    @start_1_button = NxButton.new(@part_1.start('@1m'))
    @start_2_button = NxButton.new(@part_2.start('@1m'))
    @stop_1_button = NxButton.new(@part_1.stop)
    @stop_2_button = NxButton.new(@part_2.stop)

    @raudio = Audio.new.render(@synth, @sampler, @part_1, @part_2)
    @nexus = Nexus.new.render(@start_1_button, @stop_1_button, @start_2_button, @stop_2_button)

  end

  def ableton_session
    @synth = AMSynth.new
    @sampler = Sampler.new(
      'C1': '/samples/lex/clap.wav',
      'D1': '/samples/lex/snare.wav',
      'C#1': '/samples/lex/gick.wav'
      )
    @synth.to_master
    @sampler.to_master
    a = Ableton.new('more-clips.xml')
    parts, tracks, scenes = a.build_session_for_instruments(@synth, @sampler)

    @raudio = Audio.new.render(@synth, @sampler, *parts, *tracks, *scenes)

    @nexus = Nexus.new.render(
        @start_track_1_clip_1 = NxButton.new(parts[0].start_in_session(tracks[0])),
        @start_track_1_clip_2 = NxButton.new(parts[1].start_in_session(tracks[0])),
        @start_track_2_clip_1 = NxButton.new(parts[2].start_in_session(tracks[1])),
        @start_track_2_clip_2 = NxButton.new(parts[3].start_in_session(tracks[1])),
        @start_track_2_clip_3 = NxButton.new(parts[4].start_in_session(tracks[1])),
        @start_scene_1 = NxButton.new(scenes[0].start_scene),
        @start_scene_2 = NxButton.new(scenes[1].start_scene),
        @start_scene_3 = NxButton.new(scenes[2].start_scene),
        )
   
    #   @stop_track_1 = NxButton.new(@part_1_1.stop_all),
    #   @stop_track_2 = NxButton.new(@part_2_1.stop_all)
    # )
  end

  def experiment
  end

  def menu
  end
end
