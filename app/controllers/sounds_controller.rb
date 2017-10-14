class SoundsController < ApplicationController
  def sine
  	@osc = Oscillator.new(frequency: 220, volume: 0)
  	@osc.to_master
  	@osc.start
  	@osc2 = Oscillator.new(frequency: 110, volume: -20)
  	@osc2.to_master
  	@osc2.start
  	@g = Oscillator.new(frequency: 440)
  	@raudio = Audio.new.render(@osc, @osc2, @g)
  end

  def sampler
  end
end
