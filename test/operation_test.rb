require 'test_helper'
require 'photo_organiser/operation'
require 'photo_organiser/exif_info_provider'
require 'fileutils'

class OperationTest < Minitest::Test
  DEST = '.photo_tests'.freeze

  def setup
    FileUtils.mkdir(DEST)
    FileUtils.cp('images/image.jpg', DEST)
  end

  def teardown
    FileUtils.rm_rf(DEST)
  end

  def test_that_a_photo_can_be_copied_to_date_folders
    pattern = '%Y/%m/%d'
    exif_info = PhotoOrganiser::ExifInfoProvider.get_info("#{DEST}/image.jpg")
    opts = { pattern: pattern, destination: DEST, move: false }

    PhotoOrganiser::Operation.perform([exif_info], opts)

    assert File.exist?("#{DEST}/2004/09/09/image.jpg")
    assert File.exist?("#{DEST}/image.jpg")
  end

  def test_that_a_photo_can_be_moved_to_date_folders
    pattern = '%Y/%m/%d'
    exif_info = PhotoOrganiser::ExifInfoProvider.get_info("#{DEST}/image.jpg")
    opts = { pattern: pattern, destination: DEST, move: true }

    PhotoOrganiser::Operation.perform([exif_info], opts)

    assert File.exist?("#{DEST}/2004/09/09/image.jpg")
    refute File.exist?("#{DEST}/image.jpg")
  end
end
