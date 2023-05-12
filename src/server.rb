require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/user'

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


  get '/game' do
    # logger.info 'USANDO LOGGER INFO EN GAME PATH'
    # name = params[:name]
    # "Bienvenido, #{name}!"
    erb :'juego'
  end


  ## Para autentificar que la cuenta del usuario haya sido creada.
  post '/authenticate' do
    name = params[:uname]
    password = params[:psw]

    ##Verifica la existencia del usuario
    isCorrect = User.find_by(name: name, password: password)
    if isCorrect
      redirect "/game"
    else
      redirect '/login-error'
    end
  end

  ## Solamente envia un mensaje
  ## Podriamos cambiarlo y ponerle un boton el cual retorne de vuelta a el login.
  get '/login-error' do
    'User o Contrseña equivocada'
  end


  ##Permite poder registrar un usuario correctamente.
  post '/register' do
    name = params[:uname]
    password = params[:psw]

    ##Verifica si el usuario existe o no
    exist = User.find_by(name: name)

    ## El usuario existe no lo crea
    if exist
      redirect '/register-error'
    else
      ## El usuario no existe, se crea
      user = User.new(name: name, password: password)

      if user.save
        redirect '/'
      else
        redirect '/register-error'
      end
    end
  end


  ## Solamente envia un mensaje
  ## Podriamos cambiarlo y ponerle un boton el cual retorne de vuelta a el register.
  get '/register-error' do
    'El nombre de usuario ya esta en uso'
  end


  ## PAGINA DE LOGIN Y REGISTER
  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  get '/' do
    erb :'login'
  end

  get '/registrar' do
    erb :'register'
  end
end

