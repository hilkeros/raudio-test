class RulumuController < ApplicationController
	def paradoxes
		@ableton = Ableton.new('paradoxes simplers only.als')

    beats 	= 	@ableton.midi_tracks[0].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	snare 	= 	@ableton.midi_tracks[1].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	pad 		= 	@ableton.midi_tracks[2].simpler.build_sampler('/samples/rulumu/mp3/')
   	bell 		= 	@ableton.midi_tracks[3].simpler.build_sampler('/samples/rulumu/mp3/')
   	east 		= 	@ableton.midi_tracks[4].simpler.build_sampler('/samples/rulumu/mp3/')
   	hihat 	= 	@ableton.midi_tracks[5].drum_rack.build_sampler('/samples/rulumu/mp3/')
   	low_c 	= 	@ableton.midi_tracks[6].simpler.build_sampler('/samples/rulumu/mp3/')
   	high_c 	= 	@ableton.midi_tracks[7].simpler.build_sampler('/samples/rulumu/mp3/')

    @ableton.instruments = [beats, snare, pad, bell, east, hihat, low_c, high_c]

   	@ableton.instruments.each do |instrument|
      instrument.to_master
      instrument.send('reverb')
      instrument.send('delay')
    end

    reverb = JCReverb.new(0.7)
    reverb.make_bus('reverb')
    delay = FeedbackDelay.new('4t', 0.8)
    delay.make_bus('delay')

   	parts, tracks, scenes = @ableton.build_session_for_instruments(*@ableton.instruments)
    @raudio = Audio.new(bpm: 80).render(reverb, delay, *@ableton.instruments, *parts, *tracks, *scenes)

    @nexus, @grid = @ableton.build_interface(parts, tracks, scenes, [reverb, delay])
    @mix = Mix.new
	end

  def synth
    ableton = Ableton.new('paradoxes simplers only.als')
    pad     =   ableton.midi_tracks[2].simpler.build_sampler('/samples/rulumu/mp3/')
    delay = FeedbackDelay.new('8n', 0.5)
    pad.connect(delay)
    delay.to_master
    #pad.to_master
    @raudio = Audio.new.render(delay, pad)
    @midi = Midi.new(pad).script
  end

  def interactive
    @ableton = Ableton.new('paradoxes simplers only.als')
    beats   =   @ableton.midi_tracks[0].drum_rack.build_sampler('/samples/rulumu/mp3/')
    snare   =   @ableton.midi_tracks[1].drum_rack.build_sampler('/samples/rulumu/mp3/')
    pad     =   @ableton.midi_tracks[2].simpler.build_sampler('/samples/rulumu/mp3/')
    bell    =   @ableton.midi_tracks[3].simpler.build_sampler('/samples/rulumu/mp3/')
    east    =   @ableton.midi_tracks[4].simpler.build_sampler('/samples/rulumu/mp3/')
    hihat   =   @ableton.midi_tracks[5].drum_rack.build_sampler('/samples/rulumu/mp3/')
    low_c   =   @ableton.midi_tracks[6].simpler.build_sampler('/samples/rulumu/mp3/')
    high_c  =   @ableton.midi_tracks[7].simpler.build_sampler('/samples/rulumu/mp3/')

    @ableton.instruments = [beats, snare, pad, bell, east, hihat, low_c, high_c]

    @ableton.instruments.each do |instrument|
      instrument.to_master
      instrument.send('reverb')
      instrument.send('delay')
    end

    reverb = JCReverb.new(0.7)
    reverb.make_bus('reverb')
    delay = FeedbackDelay.new('4t', 0.1)
    delay.make_bus('delay')

    parts, tracks, scenes = @ableton.build_session_for_instruments(*@ableton.instruments)
    @raudio = Audio.new(bpm: 80).render(reverb, delay, *@ableton.instruments, *parts, *tracks, *scenes)
    @nexus, @grid = @ableton.build_interface(parts, tracks, scenes, [reverb, delay])
    @mix = Mix.find_by_name('mix2')

    @start_everything = Nexus.new.render(@start_scene_1 = NxButton.new(scenes[0].start_scene))
    start_second_scene = ScrollY.new('>500', scenes[1].start_scene)
    start_third_scene = ScrollY.new('>2000', scenes[2].start_scene)

    increase_delay = ScrollFaderX.new(150, delay, 'feedback', '/1000')

    @interaction = Interaction.new.render(start_second_scene, start_third_scene, increase_delay)

  end
end