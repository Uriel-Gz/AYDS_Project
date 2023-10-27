# require 'time'
require_relative '../models/user'

class Juego < Sinatra::Application

  set :views, File.expand_path('../../views', __FILE__)

  get '/principal' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @temas = Topic.all
    session[:indice] = 0
    session[:tema_id] = 0
    erb :principal
  end
end
