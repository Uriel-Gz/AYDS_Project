# Controlador para vista principal

class Principal < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/principal' do
    @moment_day = Time.now
    @moment_day = @moment_day.hour - 3
    @temas = Topic.all
    session[:indice] = 0
    session[:tema_id] = 0
    erb :principal
  end
end
