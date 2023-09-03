require 'rack/test'
require 'sinatra/activerecord'
require_relative '../../server'
require_relative '../../models/user'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    # Devuelve la clase correspondiente a la Application definida en server.rb
    App
  end
  context 'Routes without logging user' do
    it 'testing route register' do
      get '/' # Accede a la ruta '/'
      expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
    end

    it 'probando la ruta registrar' do
      get '/registrar'
      expect(last_response.status).to eq(200)
    end

    it 'register correct' do
      post '/register', {uname: 'Santi', psw: 'pas1234', psw2: 'pas1234', email: 'santiago010@mail.com'}
      expect(last_response.status).to eq(200)
    end

    it 'register password not equal' do
      post '/register', {uname: 'Santioooo', psw: 'pas1234', psw2: 'pas12345', email: 'santiago010@mail.com'}
      expect(last_response.status).to eq(200)
    end

    it 'register user exist' do
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      post '/register', {uname: 'Santioo', psw: 'lolero123', psw2: 'lolero123', email: 'santiago0100@mail.com'}
      expect(last_response.status).to eq(200)
    end


    it 'authenticate of user' do
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      post '/authenticate', { uname: 'Santioo', psw: 'pas1234' }
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path_info).to eq('/principal')
    end


    it 'not authenticate of user' do
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      post '/authenticate', { uname: 'Santioo', psw: 'pas12345' }
      expect(last_response.status).to eq(200)
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

    it 'trying to modify level with user verification' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1 }
      # Realiza una solicitud GET a una ruta protegida (por ejemplo, '/principal')
      get '/modificar_perfil', {}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

    it 'should redirect to error_modificar if user with new name already exists' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1 }
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      # Realiza una solicitud POST a la ruta '/modify_profile' con un nuevo nombre que ya existe
      post '/modify_profile', { name: 'Santioo' }, 'rack.session' => session

      # Verifica que el código de estado sea 302 (redirección) hacia '/error_modificar'
      follow_redirect!
      expect(last_request.path_info).to eq('/error_modificar')
    end

      #COMO AL INGRESAR A / y ya hay un usuario registrado te lleva a /principal
      it 'testing the login route with a logged in user' do
        session = { user_id: 1 }
        get '/', {}, 'rack.session' => session
        # Verifica que se haya redireccionado
        expect(last_response.status).to eq(302)
        # Verifica que la redirección haya sido '/principal'
        follow_redirect!
        expect(last_request.path_info).to eq('/principal')
      end

    it 'Testing the profile route with user verification' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1 }
      # Realiza una solicitud GET a una ruta
      get '/perfil', {}, 'rack.session' => session
      # Verifica que el código de estado sea 200 (éxito) o el que uses para indicar una sesión iniciada
      expect(last_response.status).to eq(200)
    end


    it 'should allow modifying the profile if the new name is unique' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1 }
        user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
        # Realiza una solicitud POST a la ruta '/modify_profile' con nuevos valores
        post '/modify_profile', { name: 'NombreUnico', psw:'pass1234', email:'santiago01@mail.com', imagen:'lolero.jpg' }, 'rack.session' => session
        # Verifica que el código de estado sea 302 osea que direccione.
        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.path_info).to eq('/perfil')
      end

  end

  context 'Testing routes with user verification' do
    it 'testing /logros with user verification' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1 }
      # Realiza una solicitud GET a la ruta /logros
      get '/logros', {}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

    it 'verify /principal with verification' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1, tema_id: 1}
      get '/principal', {}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

    it 'testing the route /niveles' do
      # Simula una sesión de usuario iniciada
      session = { user_id: 1, tema_id: 1}
      topic = Topic.new(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
      question = Question.new(description: "2+2?", value: 12, nivel_q: 1, topic_id: 1)
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      get '/niveles', {tema: 1}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

    it 'testing the route /guia' do
      session = { user_id: 1 , tema_id: 1}
      get '/guia', {}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end
  end


  context 'prob game' do

    it 'testing the path modify /game' do
      get '/game'
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path_info).to eq('/')
    end

    it 'probando las preguntas del juego' do
      session = { user_id: 1 }
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      topic = Topic.new(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
      question = Question.new(description: "2+2?", value: 12, nivel_q: 1, topic_id: 1)
      question = Question.new(description: "3+3?", value: 12, nivel_q: 1, topic_id: 1)
      post '/game', { tema: 1, nivel: 1}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

    it 'probando la verificacion de respuestas del juego' do
      session = { user_id: 1 }
      user = User.new(name:"Santioo", email:"santiago010@mail.com", password:"pas1234")
      topic = Topic.new(nombre: "Samess", descripcion: "pruebaasdsadsad asd a", guia: "asdasdasd asd asd asdasdasdas")
      question = Question.new(description: "2+2?", value: 12, nivel_q: 1, topic_id: 1)
      Option.create(description: "4", isCorrect: true, question_id: 1)
      Option.create(description: "3", isCorrect: false, question_id: 1)
      Option.create(description: "2", isCorrect: false, question_id: 1)
      Option.create(description: "6", isCorrect: false, question_id: 1)
      post '/verificar', { opcionElegida: 1, question: 1, tema: 1, nivel: 1}, 'rack.session' => session
      expect(last_response.status).to eq(200)
    end

  end

end
