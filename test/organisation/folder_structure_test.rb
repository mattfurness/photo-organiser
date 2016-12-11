require 'test_helper'
require 'photo_organiser/organisation/folder_structure'
require 'exifr'

class FolderStructureTest < Minitest::Test
  DEST = 'Pictures'

  def test_that_folder_are_date_formatted
    pattern = "%Y/%m/%d"
    opts = {pattern: pattern, destination: DEST}
    date_path = PhotoOrganiser::Organisation.path_to_structure(PhotoOrganiser::ExifInfoProvider.get_info("images/image.jpg"), opts)

    assert_equal date_path, "Pictures/2004/09/09"
  end
end
