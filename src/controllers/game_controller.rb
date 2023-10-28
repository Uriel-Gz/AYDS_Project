# Controlador de rutas para los niveles de juego y de practica

class JuegoYPractica < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/niveles' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    session[:tema_id] = params[:tema]
    @tema = Topic.find_by(id: session[:tema_id])
    @user = User.find_by(id: session[:user_id])
    @respondidas = @user.questions.pluck(:id)
    @niveles_tema = @tema.questions.distinct.pluck(:nivel_q).count
    erb :niveles
  end


  post '/game' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])
    @nivel = params[:nivel]
    # Permite obtener los id de las preguntas que respondio
    @respondidas = @user.questions.pluck(:id)
    @preguntas_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    @questions = @preguntas_nivel.where.not(id: @respondidas)

    # Se obtiene el numero de preguntas por nivel
    @numero_por_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id).count
    # Se obtiene el numero de preguntas respondidas por nivel
    @preguntas_respondidas = @preguntas_nivel.where(id: @respondidas).count

    if @questions.any?
      # @questions.sample se utiliza para seleccionar de forma aleatoria un elemento
      # de una colección, como un arreglo o un conjunto.
      @question = @questions.sample
      if @question.nil?
        erb :preguntaterminadas
      end
      erb :pregunta
    end
  end


  post '/practica' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])
    @nivel = params[:nivel]
    # @user.questions.pluck(:id) permite obtener los id de las preguntas que respondio
    @answered = @user.questions.pluck(:id)
    @question_level = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    @questions = @question_level.where(id: @answered)

    if @questions.any?
      @question = @questions.sample
      if !@question.nil?
        erb :modopractica
      end
    end
  end

  post '/verificarPract' do
    # Parametro que otorga el ID de la respuesta seleccionada
    @respuestaID = params[:opcionElegida]
    # Parametro que otorga el ID de la pregunta respondida
    questionID = params[:question]
    @tema_id = params[:tema]
    @nivel = params[:nivel]
    # Obtengo la respuesta concreta que corresponde al ID
    @respuesta = Option.find_by(id: @respuestaID)
    # Obtengo la pregunta concreta que corresponde al ID
    @question = Question.find_by(id: questionID)
    erb :respuestaPract
  end

  post '/verificar' do
    # Parametro que otorga el ID de la respuesta seleccionada
    @respuestaID = params[:opcionElegida]
    # Parametro que otorga el ID de la pregunta respondida
    questionID = params[:question]
    @tema_id = params[:tema]
    @nivel = params[:nivel]
    # Obtengo la respuesta concreta que corresponde al ID
    @respuesta = Option.find_by(id: @respuestaID)
    # Obtengo la pregunta concreta que corresponde al ID
    @question = Question.find_by(id: questionID)

    if @respuesta.isCorrect
      @user = User.find(session[:user_id])
      res = @user.total_score + @question.value
      @user.update_column(:total_score, res)
      @user.questions << @question
      @user.save
      ranking = Ranking.find_by(user_id: @user.id)
      ranking.update(score: @user.total_score)
    end
    erb :respuesta
  end


  get '/guia' do
    @tema = Topic.find_by(id: session[:tema_id])
    erb :guia
  end
end
