# Controlador de rutas para perfil del usuario

class PerfilUsuario < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)


  get '/perfil' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @user = User.get_user(session[:user_id])
    @profile = @user.profile
    erb :perfile
  end


  get '/modificar_perfil' do
    erb :modificar_perfil
  end


  post '/modificar_perfil' do
    user = User.get_user(session[:user_id])
    profile = user.profile
    @existUser = User.find_by(name: params[:name])
    @existEmail = User.find_by(email: params[:email])

    if @existUser || @existEmail
      @modify = true
      return erb :error
    end
    user.update_column(:name, params[:name]) if params[:name].present?

    if params[:password].present?
      user.password = params[:password]
      user.save
    end

    user.update_column(:email, params[:email]) if params[:email].present?

    profile.update_column(:picture, params[:imagen]) if params[:imagen].present?

    redirect '/perfil'
  end
end
