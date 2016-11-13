module PhotoOrganiser
  module Organisation
    def self.place(exif_info, opts)
      formatted = opts[:pattern].split(File::Separator).map do |date_format|
        exif_info.date_time.strftime(date_format)
      end

      formatted.unshift(opts[:destination]).join(File::Separator)
    end
  end
end
