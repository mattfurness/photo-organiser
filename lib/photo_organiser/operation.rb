require 'fileutils'

module PhotoOrganiser
  module Operation
    def self.perform(exif_infos, opts)
      op = opts[:move] ? FileUtils.method(:mv) : FileUtils.method(:cp)

      exif_infos.each do |exif_info|
        place_at = PhotoOrganiser::PathGenerator.generate_path(exif_info, opts)
        FileUtils.mkdir_p place_at
        op.call(exif_info.full_name, place_at)
      end
    end
  end
end
