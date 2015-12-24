require 'csv'
require 'tbpgr_utils'
require 'set'

module Json2xxx
  class Core

    def initialize
    end

    def convert_csv(data, delimiter, force_quotes, write_header)
      headers = get_keys(data)
      csv = []
      CSV.generate(col_sep: delimiter, force_quotes: force_quotes) do |csv|
        csv << headers if write_header
        data.each do |hash|
          csv << headers.map { |column_name| 
            get_json_value(hash[column_name]).gsub("\n", '')
          }
        end
      end
    end

    def convert_markdown(data)
      headers = get_keys(data)
      result = []
      header = '|' + headers.join('|') + '|' + "\n" + 
      				 '|' + headers.map { |_header| ':--' }.join('|') + '|'
      data.each do |hash|
        columns = headers.map{ |column_name|
          get_json_value(hash[column_name]).gsub("\n", '').gsub("|", '')
        }
        result << columns
      end
      header + "\n" + result.to_table
    end

    def convert_backlog_wiki(data)
      headers = get_keys(data)
      result = []
      result << '|~' + headers.join('|') + '|h'

      data.each do |hash|
        columns = headers.map{ |column_name|
          get_json_value(hash[column_name]).gsub("\n", "&br;")
        }
        result << '|~' + columns.join('|') + '|'
      end
      result.join("\n")
    end

    def convert_excel(data, filepath = Time.now.strftime("%Y%m%d%H%M%S") + '.xls')
      require 'spreadsheet'
      headers = get_keys(data)

      basename = File.basename(filepath, '.*')
      Spreadsheet.client_encoding = 'UTF-8'
      workbook = Spreadsheet::Workbook.new
      workbook.add_font 'MS ゴシック'
      worksheet = workbook.create_worksheet(name: basename)
      worksheet.row(0).replace headers

      unless data.class == Array
        puts 'data is not Array'
        exit
      end
      i = 1
      data.each do |record|
        values = headers.map { |key| get_json_value(record[key]) }
        worksheet.row(i).replace values
        i = i + 1
      end
      workbook.write(filepath)
      puts "write #{filepath}"
    end

    def convert_html(data)
      headers = get_keys(data)
      result = []
      result << headers
      data.each do |hash|
        columns = headers.map{ |column_name|
          get_json_value(hash[column_name]).gsub("\n", '')
        }
        result << columns
      end
      result.to_html_table
    end

    def extract(data, fields, sort_column)
      data.map { |record|
        record = Hashie::Mash.new(record)
        fields.inject({}) { |result, field| 
          eval_string = field[0] == "[" ? "record#{field}" : "record.#{field}"
          result[field] = eval(eval_string)
          result
        }
      }
    end

    def sort(data, sort_column)
      data.sort_by{ |record|
        record[sort_column]
      }
    end

    def get_keys(data)
      keys = data.inject(Set.new) {|set, record| set.merge(record.keys) }
      keys.to_a
    end

    def get_json_value(value)
      return '' if value.nil? 
      return value.to_json if value.class == Array || value.class == Hash || value.class == Hashie::Mash
      return value.to_s
    end
  end
end
