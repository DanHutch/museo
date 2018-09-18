require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'

class CuratorTest < Minitest::Test

  def test_it_exists
    curator = Curator.new
    assert_instance_of(Curator, curator)
  end

  def test_it_starts_with_no_artists_or_photos
    curator = Curator.new
    assert_equal([], curator.artists)
    assert_equal([], curator.photographs)
  end

  def test_it_can_add_photos
    curator = Curator.new
    assert_equal([], curator.photographs)
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    expected = "1"
    actual = curator.photographs[0].id
    assert_equal(expected, actual)
    expected = "1941"
    actual = curator.photographs[-1].year
    assert_equal(expected, actual)
  end

  def test_it_can_describe_first_photo
    curator = Curator.new
    assert_equal([], curator.photographs)
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    expected = Photograph
    actual = curator.photographs.first.class
    assert_equal(expected, actual)
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    actual = curator.photographs.first.name
    assert_equal(expected, actual)
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    expected = 2
    actual = curator.artists.length
    curator.artists.each do |artist|
      assert_instance_of(Artist, artist)
    end
    expected = "1908"
    actual = curator.artists[0].born
    assert_equal(expected, actual)
    expected = "United States"
    actual = curator.artists[-1].country
    assert_equal(expected, actual)
    expected = "Henri Cartier-Bresson"
    actual = curator.artists.first.name
    assert_equal(expected, actual)
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    expected = "Henri Cartier-Bresson"
    actual = curator.find_artist_by_id("1").name
    assert_equal(expected, actual)
    expected = Artist
    actual = curator.find_artist_by_id("1").class
    assert_equal(expected, actual)
  end

  def test_it_can_find_photograph_by_id
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    expected = "Moonrise, Hernandez"
    actual = curator.find_photograph_by_id("2").name
    assert_equal(expected, actual)
    expected = Photograph
    actual = curator.find_photograph_by_id("1").class
    assert_equal(expected, actual)
  end

  def test_it_can_find_photographs_by_artist
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
      }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
      }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
      }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    assert_equal("Diane Arbus", diane_arbus.name)
    expected = 2
    actual = curator.find_photographs_by_artist(diane_arbus).length
    assert_equal(expected, actual)
    curator.find_photographs_by_artist(diane_arbus).each do |photo|
      assert_instance_of(Photograph, photo)
    end
  end

  def test_it_can_find_artists_with_multiple_photos
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
      }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
      }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
      }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    expected = Array
    actual = curator.artists_with_multiple_photographs.class
    assert_equal(expected, actual)
    expected = "Diane Arbus"
    actual = curator.artists_with_multiple_photographs.first.name
    assert_equal(expected, actual)
    expected = 1
    actual = curator.artists_with_multiple_photographs.length
    assert_equal(expected, actual)
    assert(diane_arbus == curator.artists_with_multiple_photographs.first)
  end

  def test_it_can_find_photos_by_artist_country
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
      }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
      }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
      }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
      }
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
      }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
      }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
      }
    curator = Curator.new
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)
    diane_arbus = curator.find_artist_by_id("3")
    expected = 3
    actual = curator.photographs_taken_by_artists_from("United States").length
    assert_equal(expected, actual)
    curator.photographs_taken_by_artists_from("United States").each do |photo|
      assert_instance_of(Photograph, photo)
    end
    expected = []
    actual = curator.photographs_taken_by_artists_from("Argentina")
    assert_equal(expected, actual)
  end

  def test_it_can_load_photos_from_file
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    expected = 4
    actual = curator.photographs.length
    assert_equal(expected, actual)
    curator.photographs.each do |photo|
      assert_instance_of(Photograph, photo)
    end
  end

  def test_it_can_load_artists_from_file
    curator = Curator.new
    curator.load_artists('./data/artists.csv')
    expected = 6
    actual = curator.artists.length
    assert_equal(expected, actual)
    curator.artists.each do |artist|
      assert_instance_of(Artist, artist)
    end
  end

  def test_it_can_tell_photos_taken_in_date_range


  end

end
