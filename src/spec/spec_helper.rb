  # spec/spec_helper.rb
  require 'sinatra/base'
  require 'sinatra/activerecord'

  ENV['RACK_ENV'] ||= 'test'
  ENV['APP_ENV'] ||= 'test'

  ActiveRecord::Base.logger.level = 1

  
  #require File.expand_path('../../config/environment.rb', __FILE__)

  # Carga los modelos de la aplicación
  Dir[File.expand_path('../../models/*.rb', __FILE__)].each { |file| require file }

 

  RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    config.shared_context_metadata_behavior = :apply_to_host_groups
  end