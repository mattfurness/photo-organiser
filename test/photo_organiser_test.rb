require 'test_helper'

class PhotoOrganiserTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PhotoOrganiser::VERSION
  end
end
