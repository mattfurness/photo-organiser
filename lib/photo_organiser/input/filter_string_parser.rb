require 'time'

module PhotoOrganiser
  module Input
    OPERATORS = /<=|>=|>|<|=|>/
    OPERATORS_MAP = {
      '<' => :<,
      '<=' => :<=,
      '>' => :>,
      '>=' => :>=,
      '=' => :==
    }

    def self.parse_filter_string(filter_string)
      partioned = partition(filter_string)
      lambda { |info|
        return false unless info.respond_to?(partioned.photo_attr)

        info.send(partioned.photo_attr.to_sym).send(partioned.op.to_sym, partioned.value)
      }
    end

    private

    def self.partition(filter_string)
      photo_attr, op, value = filter_string.partition(OPERATORS)

      OpenStruct.new(
        photo_attr: photo_attr,
        op: op.empty? ? OPERATORS_MAP['='] : OPERATORS_MAP[op],
        value: parse_value(value)
      )
    end

    def self.parse_value(filter_string)
      as_number = Float(filter_string) rescue false
      as_date = Time.parse(filter_string) rescue false

      as_number || as_date || filter_string.gsub(/"/, '')
    end
  end
end
