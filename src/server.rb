require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'time'

require_relative 'models/init'
require_relative 'controllers/routes'

class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  # enable :sessions activa session en todas las rutas, esto permite que
  # sinatra maneje automáticamente las cookies de sesión
  # y almacene los datos de sesión en el servidor.
  enable :sessions


  before do
    # lista de rutas restringidas
    # Estas rutas requerirán que el usuario haya iniciado sesión para acceder a ellas.
    restricted_paths = ['/principal', '/perfil', '/logros', '/practica',
                        '/modificar_perfil', '/niveles', '/guia', '/game']
    # Si la ruta actual (restricted_paths) esta incluida en la lista y no se inicio session, se vuelve al login
    redirect '/' if restricted_paths.include?(request.path_info) && !session[:user_id]
    # Si la ruta actual es la pagina '/' y hay una session activa, lo lleva a la principal
    redirect '/principal' if (request.path_info == '/') && session[:user_id]
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end

  # Controladores empleados para separar rutas
  use Autentificacion
  use Principal
  use JuegoYPractica
  use PerfilUsuario
  use NivelUsuario

  configure :production, :development do
    enable :logging
    logger = Logger.new($stdout)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end


  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')
  set :session_expire_after, 7200



end
