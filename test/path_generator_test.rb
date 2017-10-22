require 'test_helper'
require 'photo_organiser/path_generator'
require 'exifr'

class PathGeneratorTest < Minitest::Test
  DEST = 'Pictures'.freeze

  def test_that_folders_are_date_formatted
    pattern = '%Y/%m/%d'
    opts = { pattern: pattern, destination: DEST }
    date_path = PhotoOrganiser::PathGenerator.generate_path(
      PhotoOrganiser::ExifInfoProvider.get_info('images/image.jpg'),
      opts
    )

    assert_equal date_path, 'Pictures/2004/09/09'
  end
end
