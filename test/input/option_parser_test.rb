require 'test_helper'
require 'photo_organiser/input/option_parser'

class OptionParserTest < Minitest::Test
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
    result = PhotoOrganiser::Input.get_options({})
    assert_equal PhotoOrganiser::Input::DEFAULT_OPTS, result
  end

  def test_that_full_names_are_parsed
    result = PhotoOrganiser::Input.get_options(['--pattern', 'pattern', '--source', 'source', '--destination', 'destination', '--move', 'true', '--filters', '1,2,3'])
    expected = {pattern: 'pattern', source: 'source', destination: 'destination', move: true, filters: ['1', '2', '3']}
    assert_equal expected, result
  end

  def test_that_abbreviations_are_parsed
    result = PhotoOrganiser::Input.get_options(['-p', 'pattern', '-s', 'source', '-d', 'destination', '-m', 'true', '-f', '1,2,3'])
    expected = {pattern: 'pattern', source: 'source', destination: 'destination', move: true, filters: ['1', '2', '3']}
    assert_equal expected, result
  end

  def test_that_version_is_printed
    result = with_captured_stdout do
      PhotoOrganiser::Input.parse_commands(['-v', '-p', 'pattern'])
    end

    assert_equal "0.1.0#{$/}", result
  end

  def test_that_version_is_a_command
    result = with_captured_stdout do
      contains_command = PhotoOrganiser::Input.parse_commands(['-v', '-p', 'pattern'])
      assert contains_command
    end
  end
end
