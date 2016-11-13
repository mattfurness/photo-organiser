require 'exifr'

module PhotoOrganiser
  module ExifInfoProvider
    def self.get_info(photo_file)
      ExifDelegator.new(get_exif(photo_file), photo_file)
    end

    private

    def self.get_exif(photo_file)
      begin
        exif_info = EXIFR::JPEG.new(photo_file)
      rescue EXIFR::MalformedImage
        return nil
      end
    end

    class ExifDelegator < SimpleDelegator
      def initialize(exif_info, photo_file)
        super(exif_info)

        @photo_file = photo_file
      end

      def size
        @size ||= File.size(@photo_file)
      end

      def path
        @path ||= File.dirname(@photo_file)
      end

      def name
        @name ||= File.basename(@photo_file)
      end

      def extension
        @extension ||= File.extname(@photo_file)
      end

      def exif?
        @is_exif ||= __getobj__
      end
    end
  end
end
