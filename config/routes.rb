Allocations::Application.routes.draw do

  root to: 'application#test'

  controller :application do
    get :test
    get :start
    get :stop
    get :results
    get :graph
  end

end
