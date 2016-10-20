Rails.application.routes.draw do
  root 'sessions#new'
  resources 'sessions', only: [:new, :create]
  delete 'sessions' => 'sessions#destroy'
  resources 'users', only: [:create, :edit, :update]
  resources 'events'
  resources 'rsvps', only: [:create, :destroy]
  resources 'comments', only: :create
end
