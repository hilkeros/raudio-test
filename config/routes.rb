Rails.application.routes.draw do
  get 'sounds/menu'

  get 'sounds/sine'
  get 'sounds/sampler'
  get 'sounds/beat_loop'
  get 'sounds/midi'
  get 'sounds/ableton'
  get 'sounds/ableton_session'
  get 'sounds/ableton_drum'
  get 'sounds/experiment'
  get 'sounds/scroll'

  get 'wac/ableton'
  get 'wac/scroll'
  get 'wac/other_drums'
  get 'wac/effects'

  get 'rulumu/paradoxes'

  root 'sounds#menu'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
