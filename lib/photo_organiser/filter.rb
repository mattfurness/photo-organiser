module PhotoOrganiser

  def self.match?(exif_info, filters)
    all_filters = filters << method(:supported?)
    all_filters.all? { |f| f.call(exif_info) }
  end

  private

  def self.supported?(exif_info)
    exif_info.exif?
  end
end
