require './lib/file_io'
require 'pry'

class Curator #< FileIO
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).length > 1
    end
  end

  def photographs_taken_by_artists_from(place)
    ids_from_there = []
    @artists.each do |artist|
      ids_from_there << artist.id if artist.country == place
    end
    photos_by_them = []
    @photographs.find_all do |photo|
      photos_by_them << photo if ids_from_there.include?(photo.artist_id)
    end
  end

  def load_photographs(file)
    FileIO.load_photographs(file).each do |photo|
      add_photograph(photo)
    end
  end

  def load_artists(file)
    FileIO.load_artists(file).each do |artist|
      add_artist(artist)
    end
  end

end
