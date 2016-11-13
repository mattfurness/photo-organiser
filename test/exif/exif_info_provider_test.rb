require 'test_helper'
require 'photo_organiser/exif/exif_info_provider'

class FolderStructureTest < Minitest::Test
  def test_can_get_file_size
    exif_image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')

    assert_equal exif_image.size, 14801
  end

  def test_can_get_model
    exif_image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')

    assert_equal exif_image.model, 'Canon PowerShot G3'
  end

  def test_not_exif_is_nil
    exif_image = PhotoOrganiser::ExifInfoProvider.get_info('test/not_exif.jpg')

    refute exif_image.model
  end

  def test_not_image_is_nil
    exif_image = PhotoOrganiser::ExifInfoProvider.get_info('test/not_image.txt')

    refute exif_image.exif?
  end
end
