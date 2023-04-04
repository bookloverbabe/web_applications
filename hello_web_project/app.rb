# file: app.rb
require 'sinatra/base'
# require 'sinatra/reloader'

# Application class a subclass of this particular Sinatra gem
class Application < Sinatra::Base
  get '/hello' do
    name = params[:name]

    return "Hello #{name}"
  end
  
  get '/names' do
    return "Julia, Mary, Karim"
  end

  post '/sort-names' do
    sort_names = params[:names].split(", ").sort.join(", ")
    return sort_names
  end
end
  
  # This allows the app code to refresh
  # without having to restart the server.
  # configure :development do
  #   register Sinatra::Reloader
  # end

  # # Declares a route that responds to a request with:
  # #  - a GET method
  # #  - the path /
  # get '/' do
  #   # The code here is executed when a request is received and we need to 
  #   # send a response. 

  #   # We can return a string which will be used as the response content.
  #   # Unless specified, the response status code will be 200 (OK).
  #   return 'Hello!'
  # end
  # get '/posts' do
  #   return 'A list of posts'
  # end
