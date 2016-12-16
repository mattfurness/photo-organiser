require 'slop'

module PhotoOrganiser
  module OptionProvider
    DEFAULT_OPTS = {
      source: '.',
      destination: '.',
      pattern: '%Y_%m_%d',
      move: false,
      filters: []
    }.freeze

    def self.get_options(args)
      opts = Slop.parse(args) do |o|
        o.string '-s', '--source', 'The root folder of the source of the photos', default: DEFAULT_OPTS[:source]
        o.string '-d', '--destination', 'The root folder of where the date folders will go', default: DEFAULT_OPTS[:destination]
        o.string '-p', '--pattern', 'The date pattern for the grouped photos', default: DEFAULT_OPTS[:pattern]
        o.bool '-m', '--move', 'Move instead of copy the photos', default: DEFAULT_OPTS[:move]
        o.array '-f', '--filters', 'The filters for the photos to include', default: DEFAULT_OPTS[:filters]
        o.on '-v', '--version', 'print the version' do
          puts PhotoOrganiser::VERSION
          return true
        end
      end

      opts.to_hash
    end
  end
end
