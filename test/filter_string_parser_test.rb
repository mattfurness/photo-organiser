require 'test_helper'
require 'time'
require 'photo_organiser/filter_string_parser'

class FilterStringParserTest < Minitest::Test
  Parser = PhotoOrganiser::FilterStringParser

  def test_number_can_be_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num=2'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than_or_equal_as_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num>=2'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than_or_equal_as_greater_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num>=1'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num>1'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than_or_equal_as_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num<=2'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than_or_equal_as_less_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num<=3'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = 'num<3'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_date_can_be_equal
    test_obj = OpenStruct.new(time: Date.new(2016, 11, 1))
    filter_string = 'time=2016-11-01'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_missing_property
    test_obj = OpenStruct.new(foo: 'bar')
    filter_string = 'test="splat"'

    result = Parser.parse(filter_string).call(test_obj)

    refute result
  end

  def test_quoted_string
    test_obj = OpenStruct.new(foo: 'bar')
    filter_string = 'foo="bar"'

    result = Parser.parse(filter_string).call(test_obj)

    assert result
  end

  def test_file_size_conversion
    test_obj = OpenStruct.new(foo: 1024)
    filter_string = 'foo=1 KiB'

    parsed = Parser.parse(filter_string)
    result = parsed.call(test_obj)

    assert result
  end
end
