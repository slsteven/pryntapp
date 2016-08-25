Rails.application.routes.draw do
  get '/home'     => 'users#new'
  get 'users/:id' => 'users#show'
  post 'users'    => 'users#create'
  get 'users'     => 'users#index'
  # oauth
  get 'oauth' => 'oauth_users#new'
  # sessions
  post 'sessions'   => 'sessions#create'
  delete 'sessions' => 'sessions#destroy'
  # tasks
  get 'tasks'          => 'tasks#index'
  post '/add_tasks'     => 'tasks#add_task'
  post '/new_tasks'     => 'tasks#create'
  get 'tasks/:id/edit' => 'tasks#edit', as: :task
  patch '/tasks'        => 'tasks#update'
  delete '/tasks/:id'   => 'tasks#destroy'
end
