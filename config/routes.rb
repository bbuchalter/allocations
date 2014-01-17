Allocations::Application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root to: 'application#test'

  controller :application do
    get :test
    get :start
    get :stop
    get :results
    get :graph
    get :data
  end

end
