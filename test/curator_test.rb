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

end
