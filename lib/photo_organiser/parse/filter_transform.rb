require 'parslet'

module PhotoOrganiser
  module Parse
    class FilterTransform < Parslet::Transform
      rule(file_size: simple(:size)) { Filesize.from(size.to_s).to_i }
      rule(number: simple(:num)) { BigDecimal.new(num) }
      rule(date: simple(:iso_str)) { Date.parse(iso_str) }
      rule(text: simple(:text)) { text.to_s.delete('"') }
      rule(op: simple(:op)) { op == '=' ? :== : op.to_sym }
      rule(prop: simple(:prop)) { prop.to_sym }

      rule(contains: '=', prop_sym: simple(:prop), text_value: simple(:val)) do
        lambda do |info|
          FilterTransform.exec_op_on_info(info, prop, :include?, val)
        end
      end

      rule(
        std_op: simple(:op),
        prop_sym: simple(:prop),
        std_value: simple(:val)
      ) do
        lambda do |info|
          FilterTransform.exec_op_on_info(info, prop, op, val)
        end
      end

      def self.exec_op_on_info(info, prop, op, val)
        info.respond_to?(prop) ? info.send(prop).send(op, val) : false
      end
    end
  end
end
