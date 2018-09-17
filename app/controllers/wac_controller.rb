class WacController < ApplicationController

	def ableton
		ableton = Ableton.new('wacs.als')
    beats = ableton.midi_tracks[0].drum_rack.build_sampler('/samples/wac/')
   	samples = ableton.midi_tracks[1].drum_rack.build_sampler('/samples/wac/')
   	beats.to_master
   	samples.to_master

   	parts, tracks, scenes = ableton.build_session_for_instruments(beats, samples)
    @raudio = Audio.new(bpm: 80).render(beats, samples, *parts, *tracks, *scenes)

    @nexus, @grid = ableton.build_interface(parts, tracks, scenes)
	end

	def scroll
		ableton = Ableton.new('wacs.als')
    beats = ableton.midi_tracks[0].drum_rack.build_sampler('/samples/wac/')
   	samples = ableton.midi_tracks[1].drum_rack.build_sampler('/samples/wac/')
   	beats.to_master
   	samples.to_master

   	parts, tracks, scenes = ableton.build_session_for_instruments(beats, samples)
    @raudio = Audio.new(bpm: 80).render(beats, samples, *parts, *tracks, *scenes)

    start_first_scene = ScrollY.new('>500', scenes[0].start_scene)
    start_second_scene = ScrollY.new('>2000', scenes[1].start_scene)
    @interaction = Interaction.new.render(start_first_scene, start_second_scene)
	end

	def other_drums
		ableton = Ableton.new('wacs.als')
    beats = Sampler.new(
    	'C1': '/samples/lex/Kick Big Sine.wav' ,
    	'C#1': '/samples/lex/clap.wav',
  		'D1': '/samples/lex/snare.wav',
  		'E1': '/samples/lex/gick.wav'
    	)
   	samples = ableton.midi_tracks[1].drum_rack.build_sampler('/samples/wac/')
   	beats.to_master
   	samples.to_master

   	parts, tracks, scenes = ableton.build_session_for_instruments(beats, samples)
    @raudio = Audio.new(bpm: 80).render(beats, samples, *parts, *tracks, *scenes)

    start_first_scene = ScrollY.new('>500', scenes[0].start_scene)
    start_second_scene = ScrollY.new('>2000', scenes[1].start_scene)
    @interaction = Interaction.new.render(start_first_scene, start_second_scene)
	end

	def effects
		ableton = Ableton.new('wacs.als')
    beats = ableton.midi_tracks[0].drum_rack.build_sampler('/samples/wac/')
   	samples = ableton.midi_tracks[1].drum_rack.build_sampler('/samples/wac/')

   	distortion = Distortion.new
   	beats.connect(distortion)
   	distortion.to_master

   	delay = FeedbackDelay.new('8n', 0.5)
  	samples.connect(delay)
  	delay.to_master

  	parts, tracks, scenes = ableton.build_session_for_instruments(beats, samples)
    @raudio = Audio.new(bpm: 80).render(distortion, beats, delay, samples, *parts, *tracks, *scenes)

    # increase_delay = ScrollY.new(y, '>100', delay('delayTime': y/100))
    # increase_distortion = ScrollX.new(x, '>500', distortion('wet': (x - 500)/100))
    # @interaction = Interaction.new.render(increase_delay, increase_distortion)

    @nexus = Nexus.new.render(@start_scene_1 = NxButton.new(scenes[0].start_scene))
  	
	end

end