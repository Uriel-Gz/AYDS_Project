# Controlador de rutas para perfil del usuario

class PerfilUsuario < Sinatra::Application
  set :views, File.expand_path('../views', __dir__)


  get '/perfil' do
    @momentDay = Time.now
    @momentDay = @momentDay.hour - 3
    @user = User.find(session[:user_id])
    @profile = @user.profile
    erb :perfile
  end


  get '/modificar_perfil' do
    erb :modificar_perfil
  end


  post '/modificar_perfil' do
    user = User.find(session[:user_id])
    profile = user.profile
    @existUser = User.find_by(name: params[:name])
    @existEmail = User.find_by(email: params[:email])

    if @existUser || @existEmail
      @modify = true
      return erb :error
    end
    if params[:name].present?
      user.update_column(:name, params[:name])
    end

    if params[:password].present?
      user.password = params[:password]
      user.save
    end

    if params[:email].present?
      user.update_column(:email, params[:email])
    end

    if params[:imagen].present?
      profile.update_column(:picture, params[:imagen])
    end

    redirect '/perfil'
  end


end

