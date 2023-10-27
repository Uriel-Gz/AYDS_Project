require_relative '../models/user'
require_relative '../models/ranking'
require_relative '../models/topic'
require_relative '../models/question'
require_relative '../models/option'

class JuegoYPractica < Sinatra::Application

  set :views, File.expand_path('../../views', __FILE__)


  get '/niveles' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    session[:tema_id] = params[:tema]
    @tema = Topic.find_by(id: session[:tema_id]) #Consigo el TEMA de las preguntas
    @user = User.find_by(id: session[:user_id])  #Consigo el USER del usuario de la sesion
    @respondidas = @user.questions.pluck(:id)    #Permite obtener los id de las preguntas que respondio
    @niveles_tema = @tema.questions.distinct.pluck(:nivel_q).count #Cantidad niveles del tema
    erb :'niveles'
  end


  post '/game' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
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
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
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


  get '/guia'do
    @tema = Topic.find_by(id: session[:tema_id])
    erb :'guia'
  end


end
