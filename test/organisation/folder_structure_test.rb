require 'test_helper'
require 'photo_organiser/organisation/folder_structure'
require 'exifr'

class FolderStructureTest < Minitest::Test
  DEST = 'Pictures'
  SEPARATOR = File::Separator

  def test_that_folder_are_date_formatted
    pattern = "%Y#{SEPARATOR}%m#{SEPARATOR}%d"
    opts = {pattern: pattern, destination: DEST}
    date_path = PhotoOrganiser::Organisation.path_to_structure(EXIFR::JPEG.new('test/image.jpg'), opts)

    assert_equal date_path, "Pictures#{SEPARATOR}2004#{SEPARATOR}09#{SEPARATOR}09"
  end
end
