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
    # @momentDay = Time.now
    # @momentDay = @momentDay.hour - 3
    erb :modificar_perfil
  end


  post '/modify_profile' do
    nuevoName = params[:name]
    # Obtiene el usuario correspondiente al ID almacenado en el incio de session.
    user = User.find(session[:user_id])
    profile = user.profile
    @existUser = User.find_by(name: nuevoName)
    @existEmail = User.find_by(email: params[:email])

    # Si existe un usuario con ese nombre o email, no se modificará
    if @existUser || @existEmail
      @modify = true
      erb :error
    else
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
        profile.picture = params[:imagen]
        profile.save
      end
      redirect '/perfil'
    end
  end
end
