require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  
  context 'GET /albums/:id' do
    it 'returns the HTML content for a single album' do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context 'GET /albums' do
    it 'should return list of albums' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a>')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a>')
      expect(response.body).to include('<a href="/albums/5">Bossanova</a>')
    end
  end

  context 'GET /albums/new' do
    it 'should return the form to add a new album' do
      response = get('/albums/new')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('<input type="text" name="album_title" />')
      expect(response.body).to include('<input type="text" name="album_release_year" />')
      expect(response.body).to include('<input type="text" name="album_artist_id" />')
    end
  end

  context 'POST /albums' do
    it 'should validate album parameters' do
      response = post('/albums', invalid_artist_title: 'OK Computer', another_invalid_thing: 123)
      
      expect(response.status).to eq(400)
    end
    it 'should create a new album' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')
        expect(response.status).to eq(200)
        expect(response.body).to eq('')

        response = get('/albums')
        expect(response.body).to include('Voyage')
    end
  end

  context 'Get /album_list' do
    it 'returns a list of albums' do
      response = get('/album_list')

      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('Release year: 1988')
    end
  end

  context 'GET /artists/:id' do
    it 'returns the HTML content for a single artist' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('Genre: Rock')
    end
  end

  context 'GET /artists/new' do
    it 'should return the form to add a new artist' do
      response = get('/artists/new')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('<input type="text" name="artist_name" />')
      expect(response.body).to include('<input type="text" name="artist_genre" />')
    end
  end

  context 'POST /artists' do
    it 'should validate artist parameters' do
      response = post('/artists', invalid_artist_name: 'OK Computer', another_invalid_thing: 123)
      
      expect(response.status).to eq(400)
    end
    it 'should create a new artist' do
      response = post('/artists', name: 'The Black Keys', genre: 'Rock')
        expect(response.status).to eq(200)
        expect(response.body).to eq('')

        response = get('/artists')
        expect(response.body).to include('The Black Keys')
    end
  end
  
  context 'GET /artists' do
    it 'should return a list of artists' do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, The Black Keys'
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'POST /artists' do
    it 'should create a new artist' do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie')
        expect(response.status).to eq(200)
        expect(response.body).to eq('')

        response = get('/artists')
        expect(response.body).to include('Wild nothing')
    end
  end

  context 'Get /artist_list' do
    it 'returns a list of artists' do
      response = get('/artist_list')

      expect(response.status).to eq(200)
      expect(response.body).to include('Name: Pixies')
      expect(response.body).to include('Genre: Rock')
    end
  end
end