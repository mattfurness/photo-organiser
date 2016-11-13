require 'test_helper'
require 'photo_organiser/filter'
require 'photo_organiser/exif/exif_info_provider'

class FilterTest < Minitest::Test
  def test_that_filters_are_applied

    image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')
    not_exif = PhotoOrganiser::ExifInfoProvider.get_info('test/not_exif.jpg')
    infos = [image, not_exif]
    filters = [->(info) { info.name == 'image.jpg' }]
    results = PhotoOrganiser.filter(infos, filters)

    assert_equal results.length, 1
  end

  def test_that_only_supported_files_are_returned

    image = PhotoOrganiser::ExifInfoProvider.get_info('test/image.jpg')
    not_image = PhotoOrganiser::ExifInfoProvider.get_info('test/not_image.txt')
    infos = [image, not_image]
    filters = []
    results = PhotoOrganiser.filter(infos, filters)

    assert_equal results.length, 1
  end
end
