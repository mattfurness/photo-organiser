module PhotoOrganiser
  def self.match?(exif_info, filters)
    all_filters = filters << proc { |e| e.exif? }
    all_filters.all? { |f| f.call(exif_info) }
  end
end
