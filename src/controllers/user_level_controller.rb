# Controlador de rutas para logros y ranking del usuario

class NivelUsuario < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  before do
    @moment_day = Time.now
    @moment_day = @moment_day.hour - 3
  end

  get '/ranking' do
    @ranking = actualizar_ranking
    erb :ranking
  end

  def actualizar_ranking
    rankings = Ranking.order(score: :desc)
    position = 1
    rankings.each do |ranking|
      ranking.update(position: position)
      position += 1
    end

    rankings
  end

  get '/logros' do
    @user = User.get_user(session[:user_id])
    logros_obtenidos = @user.achievements.pluck(:id)
    @logros_no_obtenidos = Achievement.where.not(id: logros_obtenidos)

    @logros_no_obtenidos.each do |logro|
      @user.achievements << logro if @user.total_score >= logro.point
    end

    @logros_usuario = @user.achievements
    erb :logro
  end
end
