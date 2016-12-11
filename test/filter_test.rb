require 'test_helper'
require 'photo_organiser/filter'
require 'photo_organiser/exif/exif_info_provider'

class FilterTest < Minitest::Test
  def test_that_filters_are_used_to_match
    image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')
    filters = [->(info) { info.name != 'image.jpg' }]

    refute PhotoOrganiser.match?(image, filters)
  end

  def test_that_jpg_is_match
    image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')

    assert PhotoOrganiser.match?(image, [])
  end

  def test_that_txt_is_not_match
    not_image = PhotoOrganiser::ExifInfoProvider.get_info('test/not_image.txt')

    refute PhotoOrganiser.match?(not_image, [])
  end
end
