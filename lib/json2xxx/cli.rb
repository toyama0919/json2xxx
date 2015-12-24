require "thor"
require "json"
require 'yaml'
require 'hashie'

module Json2xxx
  class CLI < Thor

    include Thor::Actions
    class_option :fields, aliases: '-f', type: :array, desc: 'extract fields'
    class_option :sort, aliases: '-s', type: :string, desc: 'sort'
    def initialize(args = [], options = {}, config = {})
      super(args, options, config)
      @global_options = config[:shell].base.options
      return unless File.pipe?(STDIN)
      @data = parse_json(STDIN.read)
      @core = Core.new
      if @global_options['fields']
        @data = @core.extract(@data, @global_options['fields'])
      end
      if @global_options['sort']
        @data = @core.sort(@data, @global_options['sort'])
      end
    end

    desc 'delimiter', 'delimiter'
    class_option :force_quotes, type: :boolean, default: true, desc: 'write quote'
    class_option :write_header, type: :boolean, default: true, desc: 'write header'
    def delimiter(delim)
      puts @core.convert_csv(@data, delim, options['force_quotes'], options['write_header'])
    end

    desc 'tsv', 'tsv'
    class_option :force_quotes, type: :boolean, default: true, desc: 'write quote'
    class_option :write_header, type: :boolean, default: true, desc: 'write header'
    def tsv
      puts @core.convert_csv(@data, "\t", options['force_quotes'], options['write_header'])
    end

    desc 'csv', 'csv'
    class_option :force_quotes, type: :boolean, default: true, desc: 'write quote'
    class_option :write_header, type: :boolean, default: true, desc: 'write header'
    def csv
      puts @core.convert_csv(@data, ',', options['force_quotes'], options['write_header'])
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
    option :output, aliases: '-o', type: :string, default: Time.now.strftime("%Y%m%d%H%M%S") + '.xls', desc: 'output file path.'  
    def excel
      @core.convert_excel(@data, options['output'])
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


