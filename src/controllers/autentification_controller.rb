# Controlador de rutas para verificación del usuario

class Autentificacion < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)


  get '/' do
    erb :login
  end


  post '/authenticate' do
    name = params[:uname]
    password = params[:psw]
    # Verifica la existencia del usuario
    usuario = User.find_by(name: name)
    if usuario && usuario.authenticate(password)
      # Guardamos el id del usuario autenticando, user_id en la sesión como clave
      session[:user_id] = usuario.id
      redirect '/principal'
    else
      erb :error
    end
  end


  get '/registrar' do
    erb :register
  end


  post '/register' do
    name = params[:uname]
    password = params[:psw]
    repPassword = params[:psw2]
    email = params[:email]
    @existUser = User.find_by(name: name)
    @existEmail = User.find_by(email: email)

    if @existUser || @existEmail
      erb :error
    else
      @sonIguales = (password == repPassword)
      if !@sonIguales
        erb :error
      else
        # El usuario no existe, se crea y lo guarda en user
        user = User.new(name: name, email: email, password: password)
        # Se setea el puntaje en 0
        user.total_score = 0

        # Si el usuario se guarda entonces es un exito
        if user.save
          profile = Profile.new(user_id: user.id, picture: 'https://i.imgur.com/V39f2iV.png')
          Ranking.create(score: user.total_score, user_id: user.id)
          profile.save

          redirect '/'
        else
          erb :error
        end
      end
    end
  end


  post '/logout' do
    # Eliminamos el id del usuario para garantizar que esté cerro session
    session[:user_id] = nil
    redirect '/'
  end
end
