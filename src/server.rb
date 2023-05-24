require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/user'
require_relative 'models/topic'
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
        redirect '/principal';
      else
        erb :'login'
      end
    end


   #Configura la sesión para que sea activada en todas las rutas:
   #HSe usa para habilitar las sesiones en todas las rutas utilizando enable :sessions.
   #Esto permite que Sinatra maneje automáticamente las cookies de sesión
   #y almacene los datos de sesión en el servidor.
    enable :sessions

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

      redirect "/principal"
    else
      logger.info 'ERROR EN LOGIN DE USUARIO'
      erb :'loginerror'
    end
  end


  #-----------------------------------------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------------------------------------



  get '/registrar' do
    erb :'register'
  end


  ##Permite poder registrar un usuario correctamente.
  post '/register' do
    name = params[:uname]
    password = params[:psw]
    email = params[:email]

    #-----------------------------------------------
    #-----------------------------------------------

    ##Verifica si el usuario existe o no
    exist = User.find_by(name: name)

    ## El usuario existe no lo crea
    if exist
      logger.info 'NO SE PUDO REGISTRAR USUARIO'
      erb :'errorregister'
    else
      ## El usuario no existe, se crea y lo guarda en user
      user = User.new(name: name, email: email, password: password)
      #Seteo el total score en 0
      user.total_score = 0

    #-----------------------------------------------
    #-----------------------------------------------

      #Si el usuario se guarda entonces es un exito, sino error
      if user.save
        logger.info 'SE REGISTRO CON EXITO'

        profile = Profile.new(user_id: user.id, picture: "https://image.freepik.com/vector-gratis/avatar-cara-monstruo-dibujos-animados-monstruo-halloween_6996-1111.jpg")
        profile.save

        redirect '/'
      else
        logger.info 'NO SE PUDO REGISTRAR USUARIO'
        erb :'errorregister'
      end
    end
  end


#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------



  get '/principal' do
    #verificando si hay un user_id en la sesión
    #para determinar si el usuario ha iniciado sesión
    if session[:user_id]
      @temas = Topic.all
      session[:indice] = 0
      session[:tema_id] = 0
      erb :'principal'
    else
      redirect '/'
    end
  end


  post '/guardarPregunta' do
    quest = params[:pregunta]
    answer = params[:respuesta]
    #-----------------------------------------------
    #-----------------------------------------------
    q = Question.new(description: quest)  #Crea una pregunta
    q.value = 1                           #Setea el valor que tiene al responderse correcta
    q.topic_id = params[:topic]           #Le otorgo el tipo pasado como parametro que corresponde a la pregunta
    q.save                                #Lo guardo
    #-----------------------------------------------
    #-----------------------------------------------
    a = Option.new(description: answer)   #Crea una nueva opcion
    a.isCorrect = true                    # Es Correcta
    a.question_id = q.id                  #Se le otorga a la respuesta le ID de la pregunta
    a.save                                #Guarda la opcion
     #-----------------------------------------------
     #-----------------------------------------------
    redirect '/principal'
  end

#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------


    # Verificar si el usuario ha iniciado sesión
    # Verificando si hay un user_id en la sesión
    # Para determinar si el usuario ha iniciado sesión
  get '/perfil' do
    # Verificar si un usuario ha iniciado sesión
    if session[:user_id]

      user_id = session[:user_id]   #Tomamos el id del usuario que inicio sesion
      @user = User.find(user_id)    #Obtengo el usuario especifico del ID
      @profile = @user.profile      #Obtengo el perfil especifico del ID
     #-----------------------------------------------
     #-----------------------------------------------
      erb :'perfile'                #Mostramos los datos del usuario y Perfil
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

    nuevoName = params[:name]           #Parametro otorga el nuevo nombre ingresado.
    user = User.find(session[:user_id]) #Obtiene el usuario correspondiente al ID almacenado en el incio de session.
    profile = user.profile              #Obtiene el perfil del usuario determinado.

    exist = User.find_by(name: nuevoName)
    if exist                            #Si existe un usuario con ese nuevo Nombre, no lo permite.
      redirect '/error_modificar'
    end
    #-----------------------------------------------
    #-----------------------------------------------

    if params[:name].present?         #En caso de que no exista un usuario con ese nombre permite modificarlo
      user.name = params[:name]
      user.save
    end

    if params[:psw].present?         #Si se ingreso una nueva contraseña
      user.password = params[:psw]   #Cambia la contraseña
      user.save
    end

    if params[:email].present?      #Si se ingreso un nuevo email
      user.email = params[:email]   #Cambia el email
      user.save
    end

    if params[:imagen].present?         #Si se otorgo un link de imagen
      profile.picture = params[:imagen] #Cambia el link de imagen
      profile.save
    end

    redirect '/perfil'

  end

  get '/error_modificar' do
    erb :'error_modificar'
  end




  get '/logros' do
    @user = User.find(session[:user_id])

    erb :logro
  end



  post '/logout' do
    #Eliminamos el id del usuario para garantizar que esté cerro session
    session[:user_id] = nil;
    redirect '/'
  end

  get '/seleccionar' do
    if session[:user_id]
      @temas = Topic.all
      session[:indice] = 0
      session[:tema_id] = 0
      erb :'seleccionar'
    else
      redirect '/'
    end
  end

  get '/game' do
    session[:tema_id] = params[:tema]  #Lo guardo en una session para poder utilizarlo
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])  #Consigo el USER del usuario de la sesion
    #-----------------------------------------------
    #-----------------------------------------------
    @respondidas = @user.questions.pluck(:id)  #Permite obtener los id de las preguntas que respondio
    @questions = @tema.questions.where.not(id: @respondidas)  #Obtengo preguntas no respondidas

    if @questions.any?                #Pregnta si contiene algun elemento.
      @question = @questions.sample   #Se utiliza para seleccionar de forma aleatoria un elemento de una colección, como un arreglo o un conjunto.
      if @question != nil             #Es igual a nil?
        erb :'pregunta'
      end
    else
      erb :'preguntaterminadas'
    end
  end


  post '/verificar' do
    @respuestaID = params[:opcionElegida] #Parametro que otorga el ID de la respuesta seleccionada
    questionID = params[:question]        #Parametro que otorga el ID de la pregunta respondida
      #-----------------------------------------------
      #-----------------------------------------------
    @respuesta = Option.find_by(id: @respuestaID)  #Obtengo la respuesta concreta que corresponde al ID
    @question = Question.find_by(id: questionID)   #Obtengo la pregunta concreta que corresponde al ID
      #-----------------------------------------------
      #-----------------------------------------------

      # Si la respuesta otorgada es la correcta
    if @respuesta.isCorrect
      @user = User.find(session[:user_id])         # Obtengo el usuario correspondiente al id
      @user.total_score += @question.value          # Sumo al score almacenado el valor de la respuesta si fue correcta.
      @user.save                                   # Guardo
      @user.questions << @question
      @user.save
    end
    erb :'respuesta'
  end


  get '/yaRespondida' do
    redirect '/game?tema=' + session[:tema_id].to_s
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

