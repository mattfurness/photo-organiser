module PhotoOrganiser
  module PathGenerator
    def self.generate_path(exif_info, opts)
      formatted = opts[:pattern].split(File::Separator).map do |date_format|
        exif_info.date_time.strftime(date_format) unless exif_info.date_time.nil?
      end

      formatted.unshift(opts[:destination]).join('/')
    end
  end
end
