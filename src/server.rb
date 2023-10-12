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
require_relative 'models/achievement'
require_relative 'models/ranking'


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

    ##Establece la configuración session_expire_after a 7200 segundos (2 horas).
    ##Esta configuración define el tiempo de expiración de las sesiones.
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

    get '/' do
      erb :'login'
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
    usuario = User.find_by(name: name)
    if usuario && usuario.authenticate(password)
      #Guardamos el id del usuario autenticando la clave
      #:user_id en la sesión
      session[:user_id] = usuario.id

      redirect "/principal"
    else
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
    repPassword = params[:psw2]
    email = params[:email]

    #-----------------------------------------------
    #-----------------------------------------------

    ##Verifica si el usuario existe o no
    @exist = User.find_by(name: name)

    ## El usuario existe no lo crea
    if @exist
      erb :'errorregister'
    else
      @emailUsed = User.find_by(email: email)
      @sonIguales = (password == repPassword) || !@emailUsed
      if !@sonIguales
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
          profile = Profile.new(user_id: user.id, picture: "https://i.imgur.com/V39f2iV.png")
          Ranking.create(score: user.total_score, user_id: user.id) #Agrega el usuario al ranking
          profile.save

          redirect '/'
        else
          erb :'errorregister'
        end
      end
    end
  end

  


#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------



  get '/principal' do
    @temas = Topic.all
    session[:indice] = 0
    session[:tema_id] = 0
    erb :'principal'
  end

#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------

  get '/perfil' do
    # Verificar si un usuario ha iniciado sesión
    user_id = session[:user_id]   #Tomamos el id del usuario que inicio sesion
    @user = User.find(user_id)    #Obtengo el usuario especifico del ID
    @profile = @user.profile      #Obtengo el perfil especifico del ID
   #-----------------------------------------------
   #-----------------------------------------------
    erb :'perfile'                #Mostramos los datos del usuario y Perfil
  end

  get '/modificar_perfil' do
    erb :'modificar_perfil'
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
      user.update_column(:name,params[:name]) #Cambia el nombre
    end
    if params[:password].present?     #Si se ingreso una nueva contraseña   
      user.password = params[:password]
      user.save  #Cambia la contraseña 
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

  get '/error_modificar' do
    erb :'error_modificar'
  end


  post '/logout' do
    #Eliminamos el id del usuario para garantizar que esté cerro session
    session[:user_id] = nil;
    redirect '/'
  end


  get '/niveles' do
    session[:tema_id] = params[:tema]
    @tema = Topic.find_by(id: session[:tema_id]) #Consigo el TEMA de las preguntas
    @user = User.find_by(id: session[:user_id])  #Consigo el USER del usuario de la sesion
    @respondidas = @user.questions.pluck(:id)    #Permite obtener los id de las preguntas que respondio
    @niveles_tema = @tema.questions.distinct.pluck(:nivel_q).count #Cantidad niveles del tema
    erb :'niveles'
  end


  post '/game' do
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])  #Consigo el USER del usuario de la sesion
    @nivel = params[:nivel]
    #-----------------------------------------------
    #-----------------------------------------------
    @respondidas = @user.questions.pluck(:id)  #Permite obtener los id de las preguntas que respondio
    @preguntas_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    @questions = @preguntas_nivel.where.not(id: @respondidas) #Obtengo preguntas no respondidas

    @numero_por_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id).count #Numero de preguntas por nivel
    @preguntas_respondidas = @preguntas_nivel.where(id: @respondidas).count       #Numero de preguntas respondidas por nivel

    if @questions.any?                #Pregnta si contiene algun elemento.
      @question = @questions.sample   #Se utiliza para seleccionar de forma aleatoria un elemento de una colección, como un arreglo o un conjunto.
      if @question != nil             #Es igual a nil?
        erb :'pregunta'
      end
    else
      erb :'preguntaterminadas'
    end
  end


  post '/practica' do
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])  #Consigo el USER del usuario de la sesion
    @nivel = params[:nivel]

    @answered = @user.questions.pluck(:id)  #Permite obtener los id de las preguntas que respondio
    @question_level = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    @questions = @question_level.where(id: @answered)

    if @questions.any?
      @question = @questions.sample
      if @question != nil
        erb :'modopractica'
      end
    end

  end

  post '/verificarPract' do
    @respuestaID = params[:opcionElegida] #Parametro que otorga el ID de la respuesta seleccionada
    questionID = params[:question]        #Parametro que otorga el ID de la pregunta respondida
    @tema_id = params[:tema]
    @nivel = params[:nivel]
    #-----------------------------------------------
    #-----------------------------------------------
    @respuesta = Option.find_by(id: @respuestaID)  #Obtengo la respuesta concreta que corresponde al ID
    @question = Question.find_by(id: questionID)   #Obtengo la pregunta concreta que corresponde al ID
      #-----------------------------------------------
      #-----------------------------------------------
    erb :'respuestaPract'
  end

  before do
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end



  post '/verificar' do
    @respuestaID = params[:opcionElegida] #Parametro que otorga el ID de la respuesta seleccionada
    questionID = params[:question]        #Parametro que otorga el ID de la pregunta respondida
    @tema_id = params[:tema]
    @nivel = params[:nivel]
    #-----------------------------------------------
    #-----------------------------------------------
    @respuesta = Option.find_by(id: @respuestaID)  #Obtengo la respuesta concreta que corresponde al ID
    @question = Question.find_by(id: questionID)   #Obtengo la pregunta concreta que corresponde al ID
      #-----------------------------------------------
      #-----------------------------------------------

      # Si la respuesta otorgada es la correcta
    if @respuesta.isCorrect
      @user = User.find(session[:user_id])   # Obtengo el usuario correspondiente al id
      res  = @user.total_score + @question.value          # Sumo al score almacenado el valor de la respuesta si fue correcta.
      @user.update_column(:total_score,res)               # actualizo puntaje total
      @user.questions << @question
      @user.save
      ranking = Ranking.find_by(user_id: @user.id)
      ranking.update(score: @user.total_score)
    end
    erb :'respuesta'
  end

  get '/ranking' do
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

  get '/guia'do
    @tema = Topic.find_by(id: session[:tema_id])
    erb :'guia'
  end



end



