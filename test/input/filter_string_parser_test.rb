require 'test_helper'
require 'photo_organiser/input/filter_string_parser'

class FilterStringParserTest < Minitest::Test
  def test_number_can_be_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num=2"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than_or_equal_as_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num>=2"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than_or_equal_as_greater_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num>=1"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_greater_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num>1"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than_or_equal_as_equal
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num<=2"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than_or_equal_as_less_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num<=3"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_number_can_be_less_than
    test_obj = OpenStruct.new(num: 2)
    filter_string = "num<3"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_date_can_be_equal
    test_obj = OpenStruct.new(time: Time.new(2016,11,1))
    filter_string = "time=2016-11-1"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_missing_property
    test_obj = OpenStruct.new(foo: 'bar')
    filter_string = "test=splat"

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    refute result
  end

  def test_quoted_string
    test_obj = OpenStruct.new(foo: 'bar')
    filter_string = 'foo="bar"'

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end

  def test_unquoted_string
    test_obj = OpenStruct.new(foo: 'bar')
    filter_string = 'foo=bar'

    result = PhotoOrganiser::Input.parse_filter_string(filter_string).call(test_obj)

    assert result
  end
end
