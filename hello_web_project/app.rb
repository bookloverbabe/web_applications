# file: app.rb
require 'sinatra/base'
# require 'sinatra/reloader'

# Application class a subclass of this particular Sinatra gem
class Application < Sinatra::Base

  get '/hello' do
    return erb(:index)
  end

  # get '/hello' do
  #  name = params[:name]

  #  return "Hello #{name}"
  # end
  
  get '/names' do
    return "Julia, Mary, Karim"
  end

  post '/sort-names' do
    sort_names = params[:names].split(", ").sort.join(", ")
   return sort_names
  end
end