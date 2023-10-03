require 'rack/test'
require 'sinatra/activerecord'
require_relative '../../server'
require_relative '../../models/init.rb'


RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # Devuelve la clase correspondiente a la Application definida en server.rb
    App
  end

  context 'Routes without logging user' do

    it 'register correct' do
      post '/register', {uname:'Santiago', psw:'pas1236', psw2:'pas1236', email:'santiagol010@gmail.com'}
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path_info).to eq('/')
      Profile.destroy_all
      Ranking.destroy_all
      User.destroy_all
    end

    it 'register password not equal' do
      post '/register', {uname: 'Santioo', psw: 'pas1234', psw2: 'pas12345', email: 'santiago010@gmail.com'}
      expect(last_response.status).to eq(200)
    end

  end
  describe 'lol' do
    it 'authenticate of user' do
      @user = User.create(name:"Santioo", email:"santiago010@gmail.com", password:"pas1234", total_score: 5)
      post '/authenticate', {uname:'Santioo', psw:'pas1234' }
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path_info).to eq('/principal')
      @user.destroy
    end

    it 'testing route register' do
      get '/' # Accede a la ruta '/'
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end

    it 'probando la ruta registrar' do
      get '/registrar'
      expect(last_response.status).to eq(200)
    end

    it 'register user exist' do
      @user = User.create(name:"Santioo", email:"santiago010@gmail.com", password:"lolero123", total_score: 5)
      post '/register', {uname: 'Santioo', psw: 'lolero123', psw2: 'lolero123', email: 'santiago0100@gmail.com'}
      expect(last_response.status).to eq(200)
      @user.destroy
    end

    it 'not authenticate of user' do
      @user = User.create(name:"Santioo", email:"santiago010@gmail.com", password:"pas1234", total_score: 5)
      post '/authenticate', { uname: 'Santioo', psw: 'pas12345' }
      expect(last_response.status).to eq(200)
      @user.destroy
    end

    it 'testing the POST /logout route' do
      # Realiza una solicitud POST a la ruta '/logout'
      post '/logout'

      # Verifica que redireccione a '/'
      expect(last_response.status).to eq(302) # Código de estado 302 (redireccion)
      follow_redirect!
      expect(last_request.path_info).to eq('/')
    end
  end

  context 'probando perfil' do
    before(:each) do
      # Simula una sesión de usuario iniciada
      @user = User.create(name:"Santioo", email:"santiago010@mail.com", password:"pas1234", total_score: 5)
      @profile = Profile.create(user_id: @user.id)
      @session = {user_id: @user.id}
    end

    after(:each) do
      @session = nil
      @profile.destroy
      @user.destroy
    end

    it 'trying to modify level with user verification' do
      # Realiza una solicitud GET a una ruta protegida (por ejemplo, '/principal')
      get '/modificar_perfil', {}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
    end

    it 'Testing the profile route with user verification' do
      # Realiza una solicitud GET a una ruta
      get '/perfil', {}, 'rack.session' => @session
      # Verifica que el código de estado sea 200 (éxito) o el que uses para indicar una sesión iniciada
      expect(last_response.status).to eq(200)
    end


    #COMO AL INGRESAR A / y ya hay un usuario registrado te lleva a /principal
    it 'testing the login route with a logged in user' do
      get '/', {}, 'rack.session' => @session
      # Verifica que se haya redireccionado
      expect(last_response.status).to eq(302)
      # Verifica que la redirección haya sido '/principal'
      follow_redirect!
      expect(last_request.path_info).to eq('/principal')
    end

  end

  context 'lolero' do
    it 'should allow modifying the profile if the new name is unique' do
      @user = User.create(name:"Santiiiiiiiii", email:"santiago010@mail.com", password:"pas1234", total_score: 5)
      @session = { user_id: @user.id}
      # Realiza una solicitud POST a la ruta '/modify_profile' con nuevos valores
      post '/modify_profile', { name: 'NombreUnico', psw:'pass1234', email:'santiago01@mail.com'}, 'rack.session' => @session
      # Verifica que el código de estado sea 302 osea que direccione.
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path_info).to eq('/perfil')
      @user.destroy
    end
  end

  context 'Testing routes with user verification' do
    before(:each) do
      # Simula una sesión de usuario iniciada
      @user = User.create(name:"Santioooooo", email:"santiago010@mail.com", password:"pas1234", total_score: 5)
      @topic = Topic.create(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
      @question = Question.create(value: 1, description: "¿2+2?", nivel_q: 1, topic_id: @topic.id)
      @session = {user_id:@user.id, tema_id:@topic.id}
    end

    after(:each) do
      @session = nil
      @user.destroy
      @topic.destroy
      @question.destroy
    end

    it 'testing /logros with user verification' do
      #Logro que el usuario va tener al tener 5 puntos.
      @achievement = Achievement.create(name: "Campeon", description: "completa 16 lecciones", point: 1)
      get '/logros', {}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
      @achievement.destroy
    end

    it 'verify /principal with verification' do
      get '/principal', {}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
    end

    it 'testing the route /niveles' do
      get '/niveles', {tema: 1}, 'rack.session' => @session
      @question.destroy
      @topic.destroy
      expect(last_response.status).to eq(200)
    end

    # it 'testing the route /niveles' do
    #  get '/niveles', {tema: @topic.id}, 'rack.session' => @session
    # #  @question.destroy
    # #  @topic.destroy
    #  expect(last_response.status).to eq(200)
    # end

    it 'testing the route /niveles' do
      get '/niveles', {tema: @topic.id}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
    end

    it 'testing the route /guia' do
      get '/guia', {}, 'rack.session' => @session.merge(tema_id: @topic.id)
      expect(last_response.status).to eq(200)
    end

    # it 'testing the route /guia' do
    #  get '/guia', {}, 'rack.session' => @session
    #  expect(last_response.status).to eq(200)
    # end
  end


  context 'prob game' do

    before(:each) do
      @user = User.create(name:"Santioooo", email:"santiago010@mail.com", password:"pas1234", total_score: 5)
      @session = { user_id: @user.id }
      @topic = Topic.create(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
      @question = Question.create(value: 1, description: "¿2+2?", nivel_q: 1, topic_id: @topic.id)
      @question2 = Question.create(value: 1, description: "¿3+3?", nivel_q: 1, topic_id: @topic.id)
      @option = Option.create(description: "4", isCorrect: true, question_id: @question.id)
    end

    after(:each) do
      @session = nil
      @user.destroy
      @topic.destroy
      @question.destroy
      @question2.destroy
      @option.destroy
    end

    it 'probando las preguntas del juego' do
      post '/game', { tema: 1, nivel: 1}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
    end
    #it 'probando las preguntas del juego' do
    #  post '/game', { tema: @topic.id, nivel: @question.nivel_q}, 'rack.session' => @session
    #  expect(last_response.status).to eq(200)
    #end



    it 'probando la verificacion de respuestas del juego' do
      post '/verificar', {opcionElegida:@option.id, question:@question.id, tema:@topic.id, nivel:@question.nivel_q}, 'rack.session' => @session
      expect(last_response.status).to eq(200)
    end

  end


  context 'prob pract' do
    before(:each) do
     @user = User.create(name:"Santioooo", email:"santiago010@mail.com", password:"pas1234", total_score: 5)
     @session = {user_id: @user.id}
     @topic = Topic.create(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
     @question = Question.create(value: 1, description: "¿2+2?", nivel_q: 1, topic_id: @topic.id)
     @question2 = Question.create(value: 1, description: "¿3+3?", nivel_q: 1, topic_id: @topic.id)
     @option = Option.create(description: "4", isCorrect: true, question_id: @question.id)
   end

   after(:each) do
     @session = nil
     @user.destroy
     @topic.destroy
     @question.destroy
     @question2.destroy
     @option.destroy
   end
#

  #it 'probando las prácticas del juego' do
  #  post '/practica', { tema:1, nivel: 1}, 'rack.session' => @session
  #  expect(last_response.status).to eq(200)
  #end
   it 'probando las prácticas del juego' do
     post '/practica', {tema: @topic.id, nivel: @question.nivel_q }, 'rack.session' => @session
     expect(last_response.status).to eq(200)
   end

   it 'probando la verificacion de respuestas de la practica' do
     post '/verificarPract', {opcionElegida: @option.id, question: @question.id, tema: @topic.id, nivel: @question.nivel_q}, 'rack.session' => @session
     expect(last_response.status).to eq(200)
     @option.destroy
   end
   ##Este enrealidad tendria que ir en option @question.id pero no me deja y nose porq ayuda

  end



end
