# frozen_string_literal: true

require 'sinatra/base'
require 'slim'
require 'sprockets'
require 'uglifier'
require 'sass'
require 'execjs'

class App < Sinatra::Base
  # Main app loop class
  
  configure {
    set :server, :puma
  }

  # Set sprockets env
  set :environment, Sprockets::Environment.new

  # append assets path
  environment.append_path 'assets/stylesheets'
  environment.append_path 'assets/javascripts'

  # compress assets
  environment.js_compressor = :uglify
  environment.css_compressor = :scss

  # get assets
  get '/assets/*' do
    env['PATH_INFO'].sub!('/assets', '')
    settings.environment.call(env)
  end

  get '/' do
    slim :index
  end
  
  run! if app_file == $0
end
