namespace :get_report do
    desc "TODO"
    task rms_nomination: :environment do
        res = query_data(1)
        filename = "nomination_report#{Time.now}.to_i"
        file = write_file(res, filename)
    end
    
    task qr_item: :environment do
        res = query_data(2)
        filename = "qr_report#{Time.now}.to_i"
        file = write_file(res, filename)
    end
      
    private
    def write_file(data, filename)
        file = File.open("#{Rails.root}/public/reports/#{filename}.csv", 'w') do |f|
             f.write(data)
        end
        file
    end

    def query_data(id)
        q = Blazer::Query.find(id)
        @data_source = Blazer.data_sources[q.data_source]
        @statement = q.statement
        options = {}
        @results = Blazer::RunStatement.new.perform(@data_source, @statement, options)
        @columns = @results.columns
        @rows = @results.rows
        csv_result = csv_data(@columns, @rows, @data_source)
    end

    def csv_data(columns, rows, data_source)
        CSV.generate do |csv|
            csv << columns
            rows.each do |row|
            csv << row.each_with_index.map { |v, i| v.is_a?(Time) ? blazer_time_value(data_source, columns[i], v) : v }
            end
        end
    end

    def blazer_time_value(data_source, k, v)
        data_source.local_time_suffix.any? { |s| k.ends_with?(s) } ? v.to_s.sub(" UTC", "") : v.in_time_zone(Blazer.time_zone)
    end
  
  end