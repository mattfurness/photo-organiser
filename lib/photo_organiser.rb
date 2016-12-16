module PhotoOrganiser
  def self.organise(args = ARGV)
    opts = PhotoOrganiser::OptionProvider.get_options(args)
    filters = opts[:filters].map {|filter_string| PhotoOrganiser::FilterStringParser.parse(filter_string)}
    infos = Dir.glob("#{opts[:source]}/**/*").
      map {|file| PhotoOrganiser::ExifInfoProvider.get_info(file)}.
      find_all {|info| match?(info, filters)}

    PhotoOrganiser::Operation.perform(infos, opts)
  end
end
