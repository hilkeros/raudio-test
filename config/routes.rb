Rails.application.routes.draw do
  get 'sounds/menu'

  get 'sounds/sine'
  get 'sounds/sampler'
  get 'sounds/beat_loop'
  get 'sounds/midi'
  get 'sounds/ableton'
  get 'sounds/ableton_session'
  get 'sounds/experiment'

  root 'sounds#menu'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
