require 'exifr'

module PhotoOrganiser
  module ExifInfoProvider
    def self.get_info(photo_file)
      ExifDelegator.new(photo_file)
    end

    class ExifDelegator < SimpleDelegator
      def initialize(photo_file)
        super(get_exif(photo_file))

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

      def full_name
        @full_name ||= File.absolute_path(@photo_file)
      end

      def extension
        @extension ||= File.extname(@photo_file)
      end

      def exif?
        @is_exif ||= __getobj__ && __getobj__.exif?
      end

      private

      def get_exif(photo_file)
        EXIFR::JPEG.new(photo_file)
      rescue EXIFR::MalformedImage
        return nil
      end
    end
  end
end
