# Controlador de rutas para los niveles de juego y de practica

class JuegoYPractica < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  before do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
  end


  get '/niveles' do
    @tema, @user = get_tema_and_user(params, session)
    session[:tema_id] = params[:tema]
    @respondidas = User.questions_responded(@user)
    @niveles_tema = Topic.question_levels_count(@tema)

    erb :niveles
  end


  post '/game' do
    @tema, @user = get_tema_and_user(params, session)
    @nivel = params[:nivel]

    respondidas = User.questions_responded(@user)
    preguntas_nivel = Question.get_questions_level_topic(@nivel, @tema.id)

    @questions = preguntas_nivel.where.not(id: respondidas)
    @numero_por_nivel = preguntas_nivel.count
    @preguntas_respondidas = preguntas_nivel.where(id: respondidas).count

    if @questions.any?
      @question = @questions.sample
      erb :pregunta
    else
      erb :preguntaterminadas
    end
  end


  post '/practica' do
    @tema, @user = get_tema_and_user(params, session)
    @nivel = params[:nivel]
    # @user.questions.pluck(:id) permite obtener los id de las preguntas que respondio
    answered = User.questions_responded(@user)
    question_level = Question.get_questions_level_topic(@nivel, @tema.id)
    questions = question_level.where(id: answered)

    @question = questions.sample
    erb :modopractica
  end


  def get_tema_and_user(params, session)
    tema = Topic.get_topic(params[:tema])
    user = User.get_user(session[:user_id])
    [tema, user]
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

    user = User.get_user(user_id)
    User.add_points(user, question.value)
    user.questions << question
    user.save
    ranking = Ranking.find_by(user_id: user.id)
    Ranking.update_score(ranking, user) if ranking
  end


  get '/guia' do
    @tema = Topic.get_topic(session[:tema_id])
    erb :guia
  end
end
