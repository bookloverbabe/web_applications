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
    # Create a new repo of the album repo class
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:new_album)
  end
  
  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/album_list' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:album_list)
  end
  
  get '/albums/:id' do
    repo = AlbumRepository.new
    @album = repo.find(params[:id])

    return erb(:erb)
  end

  post '/albums' do
    if invalid_request_parameters?
      status 400
      return '' 
    end

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

  get '/artists/new' do
    return erb(:new_artist)
  end
  
  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:artist)
  end

  # # Return HTML page with list of artists
  # # This page should contain a link for each artist listed, linking to /artists/:id 
  # # where :id needs to be the corresponding artist id.
  get '/artist_list' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artist_list)
  end

  post '/artists' do
    if params[:name] == nil || params[:genre] == nil
      status 400
      return '' 
    end

    puts 'this band'
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return ''
  end
  
  def invalid_request_parameters?
    return (params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil)
  end
end