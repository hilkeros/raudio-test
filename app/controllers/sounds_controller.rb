class SoundsController < ApplicationController
  def sine
  	@osc = Oscillator.new(frequency: 200, volume: -10)
  	@osc.to_master
  	@osc.start
  	@raudio = @osc.render
  end

  def sampler
  end
end
