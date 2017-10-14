class SoundsController < ApplicationController
  def sine
  	@osc = Oscillator.new(frequency: 200, volume: -10)
  	@osc.to_master
  	@osc.start
  	@raudio = @osc.render
  	@osc2 = Oscillator.new(frequency: 380, volume: -10)
  	@osc2.to_master
  	@osc2.start
  	@raudio2 = @osc2.render
  end

  def sampler
  end
end
