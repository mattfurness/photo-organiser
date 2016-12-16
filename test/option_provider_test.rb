require 'test_helper'
require 'photo_organiser/option_provider'

class OptionProviderTest < Minitest::Test
  def with_captured_stdout
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  def test_that_default_options_are_used
    result = PhotoOrganiser::OptionProvider.get_options({})
    assert_equal PhotoOrganiser::OptionProvider::DEFAULT_OPTS, result
  end

  def test_that_full_names_are_parsed
    result = PhotoOrganiser::OptionProvider.get_options(['--pattern', 'pattern', '--source', 'source', '--destination', 'destination', '--move', 'true', '--filters', '1,2,3'])
    expected = {pattern: 'pattern', source: 'source', destination: 'destination', move: true, filters: ['1', '2', '3']}
    assert_equal expected, result
  end

  def test_that_abbreviations_are_parsed
    result = PhotoOrganiser::OptionProvider.get_options(['-p', 'pattern', '-s', 'source', '-d', 'destination', '-m', 'true', '-f', '1,2,3'])
    expected = {pattern: 'pattern', source: 'source', destination: 'destination', move: true, filters: ['1', '2', '3']}
    assert_equal expected, result
  end

  def test_that_version_is_printed
    result = with_captured_stdout do
      PhotoOrganiser::OptionProvider.get_options(['-v', '-p', 'pattern'])
    end

    assert_equal "0.1.0#{$/}", result
  end
end
