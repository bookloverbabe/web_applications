# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # To confirm that the new albums has been added to the database
  get '/albums' do
    # Create a new repo of the albumrepo class
    repo = AlbumRepository.new
    albums = repo.all

    # Get all of the album titles by mapping over the array and then joining them into a string
    response = albums.map do |album|
      album.title
    end.join(', ')
    return response
  end

  post '/albums' do
    # Create a new repo of the album repo class
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)

    return ''
  end
  
  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do |artist|
      artist.name
    end.join(', ')
    return response
  end

  post '/artists' do
    puts 'this band'
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return ''
  end
end