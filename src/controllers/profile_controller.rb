# Controlador de rutas para perfil del usuario

class PerfilUsuario < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)

  get '/perfil' do
    @moment_day = Time.now
    @moment_day = @moment_day.hour - 3
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
    @exist_user = User.find_by(name: params[:name])
    @exist_email = User.find_by(email: params[:email])

    if @exist_user || @exist_email
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
