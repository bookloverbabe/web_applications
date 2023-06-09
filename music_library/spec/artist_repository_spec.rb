require 'artist'
require 'artist_repository'

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'music_library', user: 'postgres', password: ENV['DATABASE_PASSWORD']})
  # dbname: 'music_library_test'
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  it 'finds one artist' do
    repo = ArtistRepository.new

    artist = repo.find(3)
    
    expect(artist.id).to eq(3)
    expect(artist.name).to eq('Taylor Swift')
  end

  it 'creates an album' do
    repo = ArtistRepository.new

    artist = Artist.new
    artist.name = 'Kiasmos'
    artist.genre = 'Experimental'
    repo.create(artist)

    artists = repo.all

    expect(artists.length).to eq(5)
    expect(artists.last.name).to eq('Kiasmos')
  end

  it 'finds all artists' do
    repo = ArtistRepository.new

    artists = repo.all
    
    expect(artists.length).to eq(4)
    expect(artists.first.name).to eq('Pixies')
  end
end