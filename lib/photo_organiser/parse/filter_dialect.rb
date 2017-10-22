require 'parslet'
require 'bigdecimal'
require 'filesize'

module PhotoOrganiser
  module Parse
    class FilterDialect < Parslet::Parser
      rule(:year) { match('[0-9]').repeat(4, 4) }
      rule(:month) { match('[0-9]').repeat(2, 2) }
      rule(:day) { match('[0-9]').repeat(2, 2) }
      rule(:date_separator) { str('-').repeat(1, 1) }
      rule(:date) do
        (
          year >> date_separator >> month >> date_separator >> day
        ).as(:date)
      end
      rule(:number) { match('[0-9]').repeat(1).as(:number) }
      rule(:space) { match('\s').repeat(1, 1) }
      rule(:size_unit) do
        str('B') |
          str('MB') |
          str('GB') |
          str('KB') |
          str('MiB') |
          str('GiB') |
          str('KiB')
      end

      rule(:file_size) do
        (
          match('[0-9]').repeat(1) >> space >> size_unit.repeat(1, 1)
        ).as(:file_size)
      end

      rule(:text) do
        (
          str('"').repeat(1, 1) >>
          match('[^"]').repeat(1) >>
          str('"').repeat(1, 1)
        ).as(:text)
      end

      rule(:property) { match['[:alnum:]'].repeat(1).as(:prop) }
      rule(:operator) do
        (
          str('>=') | str('<=') | str('>') | str('<') | str('=')
        ).as(:op)
      end
      rule(:filter_value) { date | file_size | number }
      rule(:filter_contains_text) do
        property.as(:prop_sym) >> str('=').as(:contains) >> text.as(:text_value)
      end
      rule(:filter_std) do
        property.as(:prop_sym) >>
          operator.as(:std_op) >>
          filter_value.as(:std_value)
      end
      rule(:filter) { filter_contains_text | filter_std }

      root(:filter)
    end
  end
end
