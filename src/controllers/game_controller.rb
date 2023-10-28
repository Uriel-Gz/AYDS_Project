# Controlador de rutas para los niveles de juego y de practica

class JuegoYPractica < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  before do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
  end

  get '/niveles' do
    session[:tema_id] = params[:tema]
    @tema = Topic.find_by(id: session[:tema_id])
    @user = User.find_by(id: session[:user_id])
    @respondidas = @user.questions.pluck(:id)
    @niveles_tema = @tema.questions.distinct.pluck(:nivel_q).count
    erb :niveles
  end


  post '/game' do
    @tema = Topic.find_by(id: params[:tema])
    @user = User.find_by(id: session[:user_id])
    @nivel = params[:nivel]

    respondidas = @user.questions.pluck(:id)
    preguntas_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    @questions = preguntas_nivel.where.not(id: respondidas)

    @numero_por_nivel = Question.where(nivel_q: @nivel, topic_id: @tema.id).count
    @preguntas_respondidas = preguntas_nivel.where(id: respondidas).count

    if @questions.any?
      @question = @questions.sample
      return erb :pregunta
    end
    erb :preguntaterminadas
  end


  post '/practica' do
    @tema = Topic.fetch_topic(params[:tema])
    @user = User.find_by(id: session[:user_id])
    @nivel = params[:nivel]
    # @user.questions.pluck(:id) permite obtener los id de las preguntas que respondio
    answered = @user.questions.pluck(:id)
    question_level = Question.where(nivel_q: @nivel, topic_id: @tema.id)
    questions = question_level.where(id: answered)

    @question = questions.sample
    erb :modopractica
  end

  post '/verificarPract' do
    respuestaID = params[:opcionElegida]
    questionID = params[:question]
    @tema_id = params[:tema]
    @nivel = params[:nivel]
    @respuesta = Option.find_by(id: respuestaID)
    @question = Question.find_by(id: questionID)
    erb :respuestaPract
  end


  post '/verificar' do
    respuestaID = params[:opcionElegida]
    @respuesta = Option.find_by(id: respuestaID)

    questionID = params[:question]
    @question = Question.find_by(id: questionID)

    @tema_id = params[:tema]
    @nivel = params[:nivel]
    user_id = session[:user_id]

    verificar_respuesta(@respuesta, @question, user_id)
    erb :respuesta
  end


  def verificar_respuesta(respuesta, question, user_id)
    return unless respuesta && question && respuesta.isCorrect

    user = User.fetch_user(user_id)
    User.add_points(user, question.value)
    user.questions << question
    user.save
    ranking = Ranking.find_by(user_id: user.id)
    Ranking.update_score(ranking, user) if ranking
  end


  get '/guia' do
    @tema = Topic.find_by(id: session[:tema_id])
    erb :guia
  end
end
