require 'test_helper'
require 'photo_organiser/filter'
require 'photo_organiser/exif_info_provider'

class FilterTest < Minitest::Test
  Provider = PhotoOrganiser::ExifInfoProvider
  def test_that_filters_are_used_to_match
    image = Provider.get_info('images/image.jpg')
    filters = [->(info) { info.name != 'image.jpg' }]

    refute PhotoOrganiser.match?(image, filters)
  end

  def test_that_jpg_is_match
    image = Provider.get_info('images/image.jpg')

    assert PhotoOrganiser.match?(image, [])
  end

  def test_that_txt_is_not_match
    not_image = Provider.get_info('images/not_image.txt')

    refute PhotoOrganiser.match?(not_image, [])
  end
end
