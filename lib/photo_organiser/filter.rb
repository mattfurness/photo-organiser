module PhotoOrganiser
  SUPPORTED_EXTENSIONS = /jpeg|jpg/i

  def self.filter(exif_infos, filters)
    all_filters = filters << method(:supported?)
    exif_infos.find_all { |je| filters.all? { |f| f.call(je) } }
  end

  private

  def self.supported?(exif_info)
    SUPPORTED_EXTENSIONS.match(exif_info.extension)
  end
end
