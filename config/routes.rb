Rails.application.routes.draw do
  root "documents#index"

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
