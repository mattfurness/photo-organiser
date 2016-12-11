require 'test_helper'

class PhotoOrganiserTest < Minitest::Test
  PHOTOS = '.photo_tests2'

  def setup
    FileUtils.mkdir(PHOTOS)
    FileUtils.cp("images/image.jpg", PHOTOS)
    FileUtils.cp("images/image2.jpg", PHOTOS)
    FileUtils.cp("images/not_exif.jpg", PHOTOS)
    FileUtils.cp("images/not_image.txt", PHOTOS)
  end

  def teardown
    FileUtils.rm_rf(PHOTOS)
  end

  def test_that_it_has_a_version_number
    refute_nil PhotoOrganiser::VERSION
  end

  def test_that_exif_image_is_copied
    args = ['--pattern', '%Y/%m/%d', '--source', PHOTOS, '--destination', "#{PHOTOS}/dest", '--move', 'true', '--filters', 'name=image2.jpg']
    PhotoOrganiser.organise(args)
    assert File.exists?("#{PHOTOS}/dest/2004/09/09/image2.jpg")
  end
end
