require 'parslet'
require 'bigdecimal'
require 'filesize'

module PhotoOrganiser
  module Parse
    class FilterDialect < Parslet::Parser
      rule(:year) { match('[0-9]').repeat(4,4) }
      rule(:month) { match('[0-9]').repeat(2,2) }
      rule(:day) { match('[0-9]').repeat(2,2) }
      rule(:date_separator) { str('-').repeat(1,1) }
      rule(:date) { (year >> date_separator >> month >> date_separator >> day).as(:date) }

      rule(:number) { match('[0-9]').repeat(1).as(:number) }
      rule(:space) { match('\s').repeat(1,1) }

      rule(:size_unit) { 
        str('B') | 
        str('MB') | 
        str('GB') | 
        str('KB') | 
        str('MiB') |
        str('GiB') |
        str('KiB')
      }
      rule(:file_size) { (match('[0-9]').repeat(1) >> space >> size_unit.repeat(1,1)).as(:file_size) }

      rule(:text) { (str('"').repeat(1,1) >> match('[^"]').repeat(1) >> str('"').repeat(1,1)).as(:text) }
      rule(:property) { (match['[:alnum:]'].repeat(1)).as(:prop) }

      rule(:operator) {
        (
          str('>=') |
          str('<=') |
          str('>') |
          str('<') |
          str('=')
        ).as(:op)
      }

      rule(:filter_value) { date | file_size | number }
      rule(:filter_contains_text) { property.as(:prop_sym) >> str('=').as(:contains) >> text.as(:text_value) }
      rule(:filter_std) { property.as(:prop_sym) >> operator.as(:std_op) >> filter_value.as(:std_value) }
      rule(:filter) { filter_contains_text | filter_std }

      root(:filter)
    end
  end
end
