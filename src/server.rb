require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'time'

require_relative 'models/user'
require_relative 'models/topic'
require_relative 'models/question'
require_relative 'models/option'
require_relative 'models/profile'
require_relative 'models/achievement'
require_relative 'models/ranking'
require_relative 'controllers/juego_controller'
require_relative 'controllers/inicio_session.rb'
require_relative 'controllers/JuegoController.rb'

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

  set :session_expire_after, 7200


    before do
      ##lista de rutas restringidas
      ##Estas rutas requerirán que el usuario haya iniciado sesión para acceder a ellas.
      restricted_paths = ['/principal', '/perfil', '/logros', '/niveles', '/modificar_perfil', '/guia', '/game', '/practica']
      ##Si la ruta actual (restricted_paths) esta incluida en la lista y no se inicio session, se vuelve al login
      if restricted_paths.include?(request.path_info) && !session[:user_id]
        redirect '/'
      end
      ##Si la ruta actual es la pagina '/' y hay una session activa, lo lleva a la principal
      if (request.path_info == '/') && session[:user_id]
        redirect '/principal'
      end
    end


    #Configura la sesión para que sea activada en todas las rutas:
    #HSe usa para habilitar las sesiones en todas las rutas utilizando enable :sessions.
    #Esto permite que Sinatra maneje automáticamente las cookies de sesión
    #y almacene los datos de sesión en el servidor.
    enable :sessions


  use Autentificacion
  use Juego
  use JuegoYPractica




  get '/perfil' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    # Verificar si un usuario ha iniciado sesión
    user_id = session[:user_id]   #Tomamos el id del usuario que inicio sesion
    @user = User.find(user_id)    #Obtengo el usuario especifico del ID
    @profile = @user.profile      #Obtengo el perfil especifico del ID
   #-----------------------------------------------
   #-----------------------------------------------
    erb :'perfile'                #Mostramos los datos del usuario y Perfil
  end

  get '/modificar_perfil' do
    # @momentDay = Time.now
    # @momentDay = @momentDay.hour - 3
    erb :'modificar_perfil'
  end



  post '/modify_profile' do
    nuevoName = params[:name]           #Parametro otorga el nuevo nombre ingresado.
    user = User.find(session[:user_id]) #Obtiene el usuario correspondiente al ID almacenado en el incio de session.
    profile = user.profile              #Obtiene el perfil del usuario determinado.
    @existUser = User.find_by(name: nuevoName)
    @existEmail = User.find_by(email: params[:email])
    if @existUser || @existEmail              #Si existe un usuario con ese nombre o email, no lo permite.
      @modify = true
      erb :'error'
    else
      if params[:name].present?         #En caso de que no exista un usuario con ese nombre permite modificarlo
        user.update_column(:name,params[:name]) #Cambia el nombre
      end
      if params[:password].present?         #Si se ingreso una nueva contraseña
        user.password = params[:password]   #Cambia la contraseña
        user.save
      end
      if params[:email].present?      #Si se ingreso un nuevo email
        user.update_column(:email,params[:email] ) #Cambia el email
      end
      if params[:imagen].present?       #Si se otorgo un link de imagen
        profile.picture = params[:imagen]  #Cambia el link de imagen
        profile.save
      end
      redirect '/perfil'
    end
  end

  before do
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end

  get '/ranking' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @ranking = actualizar_ranking
    erb :ranking
  end

  def actualizar_ranking
    # ordenamos por score
    @rankings = Ranking.order(score: :desc)
    position = 1  # posiciones pe
    # cada usuario tiene su posicion
    @rankings.each do |ranking|
      ranking.update(position: position)
      position += 1
    end

    @rankings
  end

  get '/logros' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @user = User.find(session[:user_id])
    @logros = Achievement.all
    @logrosObtenidos = @user.achievements.pluck(:id)
    @logrosNO_obtenidos = Achievement.where.not(id: @logrosObtenidos)
    @logrosNO_obtenidos.each do |logro|
      if @user.total_score >= logro.point
        @user.achievements << logro
        @user.save
      end
    end

    @logrosObtenidos = @user.achievements.pluck(:id)
    @logrosNO_obtenidos = Achievement.where.not(id: @logrosObtenidos)

    @logros_usuario = @user.achievements
    erb :logro
  end

end



