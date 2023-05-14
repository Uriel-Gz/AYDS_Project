require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/user'
require_relative 'models/question'
require_relative 'models/option'
require_relative 'models/profile'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  configure :production, :development do
    enable :logging

    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end


  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end


    ## PAGINA DE LOGIN Y REGISTER
    set :views, File.join(File.dirname(__FILE__), 'views')
    set :public_folder, File.join(File.dirname(__FILE__), 'styles')



    get '/' do
      if session[:user_id]
        redirect '/game';
      else
        erb :'login'
      end
    end


   #Configura la sesión para que sea activada en todas las rutas:
   #HSe usa para habilitar las sesiones en todas las rutas utilizando enable :sessions.
   #Esto permite que Sinatra maneje automáticamente las cookies de sesión
   #y almacene los datos de sesión en el servidor.
   configure do
    enable :sessions
  end

  ## Para autentificar que la cuenta del usuario haya sido creada.
  post '/authenticate' do
    name = params[:uname]
    password = params[:psw]

    ##Verifica la existencia del usuario
    usuario = User.find_by(name: name, password: password)
    if usuario
      logger.info 'USUARIO LOGEADO CORRECTAMENTE'
      #Guardamos el id del usuario autenticando la clave
      #:user_id en la sesión
      session[:user_id] = usuario.id

      redirect "/game"
    else
      logger.info 'ERROR EN LOGIN DE USUARIO'
      redirect '/login-error'
    end
  end

  ## Solamente envia un mensaje
  ## Podriamos cambiarlo y ponerle un boton el cual retorne de vuelta a el login.
  get '/login-error' do
    'User o Contrseña equivocada'
  end


  get '/registrar' do
    erb :'register'
  end


  ##Permite poder registrar un usuario correctamente.
  post '/register' do
    name = params[:uname]
    password = params[:psw]
    email = params[:email]


    ##Verifica si el usuario existe o no
    exist = User.find_by(name: name)

    ## El usuario existe no lo crea
    if exist
      logger.info 'NO SE PUDO REGISTRAR USUARIO'
      redirect '/register-error'
    else
      ## El usuario no existe, se crea y lo guarda en user
      user = User.new(name: name, email: email, password: password)
      #Seteo el total score en 0
      user.total_score = 0

      #Si el usuario se guarda entonces es un exito, sino error
      if user.save
        logger.info 'SE REGISTRO CON EXITO'
        redirect '/'
      else
        logger.info 'NO SE PUDO REGISTRAR USUARIO'
        redirect '/register-error'
      end
    end
  end


  ## Solamente envia un mensaje
  ## Podriamos cambiarlo y ponerle un boton el cual retorne de vuelta a el register.
  get '/register-error' do
    'El nombre de usuario ya esta en uso'
  end













  get '/game' do
    #verificando si hay un user_id en la sesión
    #para determinar si el usuario ha iniciado sesión
    if session[:user_id]
      erb :'juego'
    else
      redirect '/'
    end
  end


  post '/guardarPregunta' do
    quest = params[:pregunta]
    anw = params[:respuesta]

    q = Question.new(description: quest)
    q.value = 1
    q.topic_id = 1

    a = Option.new(description: anw)
    a.isCorrect = true

    if a.save && q.save
      redirect '/game'
    else
      redirect '/error-pregunta'
    end

  end






  get '/perfil' do
    # Verificar si el usuario ha iniciado sesión
    #verificando si hay un user_id en la sesión
    #para determinar si el usuario ha iniciado sesión
    if session[:user_id]
      user_id = session[:user_id]
      # Realiza las operaciones necesarias para obtener el usuario correspondiente al ID almacenado
      @user = User.find(user_id)
      @profile = @user.profile
      # Resto de tu código...
      erb :'perfile'
    else
      # El usuario no ha iniciado sesión, redirigir a la página de inicio de sesión o mostrar un mensaje de error
      redirect '/'
    end
  end

  get '/modificar_perfil' do
    if session[:user_id]
      erb :'modificar_perfil'
    else
      redirect '/'
    end
  end



  post '/modify_profile' do
    nuevoName = params[:name]

    user = User.find(session[:user_id])
    profile = user.profile

    exist = User.find_by(name: nuevoName)
    if exist
      redirect '/error_modificar'
    end

    if params[:name].present?
      user.name = params[:name]
      user.save
    end

    if params[:psw].present?
      user.password = params[:psw]
      user.save
    end

    if params[:email].present?
      user.email = params[:email]
      user.save
    end

    if params[:imagen].present?
      profile.picture = params[:imagen]
      profile.save
    end

    redirect '/perfil'

  end

  get '/error_modificar' do
    'el usuario ya esta en uso'
  end


  get '/logros' do
    erb :'logro'
  end



  post '/logout' do
    #Eliminamos el id del usuario para garantizar que esté cerro session
    session[:user_id] = nil;
    redirect '/'
  end





  get '/usuarios' do
    @users = User.all

    if @users.empty?
      # No se encontraron usuarios
      # Realiza una acción apropiada, como redireccionar o mostrar un mensaje de error
    else
      erb :'mostrarUsuarios'
    end
  end

end

