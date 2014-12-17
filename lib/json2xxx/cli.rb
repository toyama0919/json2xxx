require "thor"
require "json"
require 'yaml'
require 'hashie'

module Json2xxx
  class CLI < Thor

    include Thor::Actions
    class_option :fields, aliases: '-f', type: :array, desc: 'default is first data'  
    def initialize(args = [], options = {}, config = {})
      super(args, options, config)
      @global_options = config[:shell].base.options
      return unless File.pipe?(STDIN)
      @data = parse_json(STDIN.read)
      @core = Core.new
      unless @global_options['fields'].nil?
        @data = @core.extract(@data, @global_options['fields'])
      end
    end

    desc 'tsv', 'tsv'
    def tsv
      puts @core.convert_csv(@data, "\t")
    end

    desc 'csv', 'csv'
    def csv
      puts @core.convert_csv(@data, ',')
    end

    desc 'yaml', 'yaml'
    def yaml
      puts YAML.dump(@data)
    end

    desc 'markdown', 'markdown'
    def markdown
      puts @core.convert_markdown(@data)
    end

    desc 'backlog', 'backlog'
    def backlog
      puts @core.convert_backlog_wiki(@data)
    end

    desc 'html', 'html'
    def html
      puts @core.convert_html(@data)
    end

    desc 'excel', 'excel'
    def excel
      @core.convert_excel(@data)
    end

    private

    def parse_json(buffer)
      begin
        data = JSON.parse(buffer)
      rescue => e
        data = []
        buffer.lines.each do |line|
          data << JSON.parse(line)
        end
      end
      data.class == Array ? data : [data]
    end
  end
end


