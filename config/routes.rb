Allocations::Application.routes.draw do

  root to: 'application#graph'

  controller :application do
    get :test
    get :start
    get :stop
    get :results
    get :graph
    get :data
  end

end
