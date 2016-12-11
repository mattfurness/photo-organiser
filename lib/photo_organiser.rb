module PhotoOrganiser
  def self.organise(args = ARGV)
    opts = PhotoOrganiser::Input.get_options(args)
    filters = opts[:filters].map {|filter_string| PhotoOrganiser::Input.parse_filter_string(filter_string)}
    infos = Dir.glob("#{opts[:source]}/**/*").
      map {|file| PhotoOrganiser::ExifInfoProvider.get_info(file)}.
      find_all {|info| match?(info, filters)}

    PhotoOrganiser::Organisation.place(infos, opts)
  end
end
