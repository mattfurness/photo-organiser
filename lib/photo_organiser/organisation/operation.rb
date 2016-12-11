require 'fileutils'

module PhotoOrganiser
  module Organisation
    def self.place(exif_infos, opts)
      op = opts[:move] ? FileUtils.method(:mv) : FileUtils.method(:cp)

      exif_infos.each do |exif_info|
        place_at = PhotoOrganiser::Organisation.path_to_structure(exif_info, opts)
        FileUtils.mkdir_p place_at
        op.call(exif_info.full_name, place_at)
      end
    end
  end
end
