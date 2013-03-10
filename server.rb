require "rubygems"
require "sinatra/base"
require "sinatra/assetpack"
require "sinatra/backbone"
require "json"
require "net/http"
require "uri"

class AppServer < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack
  register Sinatra::JstPages
  serve_jst '/jst.js'
  #plz don't steal my api-key, have to figure out a better way to hide this
  apikey = '?api-key=e9dbe20ea8d501875e5ebdd0351caf4f:3:56645684'

  assets do
    serve '/img', from: 'app/img'

    my_js = [
      '/js/vendor/jquery.js',
      '/js/vendor/underscore.js',
      '/js/vendor/backbone.js',
      '/js/vendor/bootstrap.min.js',
      '/jst.js'
    ]

    my_js << Dir.glob("./app/js/app/**/*.coffee").each do |f| 
      f.sub!("./app", "")
      f.sub!(".coffee", ".js") 
    end

    my_js << ['/js/app.js']

    js :app, my_js

    css :application, '/css/application.css', [
      '/css/bootstrap.min.css',
      '/css/bootstrap-responsive.min.css',
      '/css/screen.css'
    ]    
  end

  get "/" do
    erb :index
  end

  get "/favicon.ico" do
    ""
  end

  get "/housemembers" do
   uri = URI.parse('http://api.nytimes.com/svc/politics/v3/us/legislative/congress/113/house/members.json' << apikey)
   Net::HTTP.get(uri)
  end
  
end
