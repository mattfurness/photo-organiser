require 'time'
require 'photo_organiser/parse/filter_dialect'
require 'photo_organiser/parse/filter_transform'

module PhotoOrganiser
  module FilterStringParser
    @@parser = PhotoOrganiser::Parse::FilterDialect.new
    @@transformer = PhotoOrganiser::Parse::FilterTransform.new

    def self.parse(filter_string)
      parsed = @@parser.parse(filter_string)
      @@transformer.apply(parsed)
    end
  end
end
