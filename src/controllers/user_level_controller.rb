# Controlador de rutas para logros y ranking del usuario

class NivelUsuario < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/ranking' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @ranking = actualizar_ranking
    erb :ranking
  end

  def actualizar_ranking
    @rankings = Ranking.order(score: :desc)
    position = 1
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
