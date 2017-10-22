require 'photo_organiser/exif_info_provider'
require 'photo_organiser/filter_string_parser'
require 'photo_organiser/operation'
require 'photo_organiser/option_provider'

module PhotoOrganiser
  def self.organise(args = ARGV)
    opts = PhotoOrganiser::OptionProvider.get_options(args)
    filters = opts[:filters].map do |filter_string|
      PhotoOrganiser::FilterStringParser.parse(filter_string)
    end
    infos = Dir.glob("#{opts[:source]}")
               .map { |file| PhotoOrganiser::ExifInfoProvider.get_info(file) }
               .find_all { |info| match?(info, filters) }

    PhotoOrganiser::Operation.perform(infos, opts)
  end

  def self.match?(exif_info, filters)
    all_filters = filters << proc { |e| e.exif? }
    all_filters.all? { |f| f.call(exif_info) }
  end
end
