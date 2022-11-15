class GenerateReportService
  attr_accessor :file

  def initialize(file_name)
    @file = File.open(file_name)
    @reports = []
    @tracks = []
    @indicators = []
  end

  def call
    parse_file_data read_file
    calculate_scores
    display_output
  end

  private

  def read_file
    file_data = file.readlines.map(&:chomp)
    file.close
    file_data
  end

  def parse_file_data(file_data)
    file_data.each do |row|
      columns = row.split
      row_type = columns[0].downcase
      send("parse_#{row_type}", columns)
    end
  end

  def parse_report(row)
    report_id = row[1]
    @reports << {id: report_id, score: 0}
  end

  def parse_track(row)
    track_id = row[1]
    report_id = row[2]

    @tracks << {
      id: track_id,
      report_id: report_id,
      score: 0
    }
  end

  def parse_indicator(row)
    indicator_id = row[2]
    track_id = row[2]
    score = row[3].to_i
    weight = row[4].to_i

    @indicators << {
      id: indicator_id,
      track_id: track_id,
      weighted_score: (score * weight)
    }
  end

  def calculate_scores
    calculate_track_scores
    calculate_report_scores
  end

  def calculate_track_scores
    @tracks.each do |track|
      indicators = @indicators.filter { |indicator| indicator[:track_id] == track[:id] }
      sum = indicators.sum { |indicator| indicator[:weighted_score] }
      track[:score] = sum / indicators.length
    end
  end

  def calculate_report_scores
    @reports.each do |report|
      tracks = @tracks.filter { |track| track[:report_id] == report[:id] }
      sum = tracks.sum { |track| track[:score] }
      report.merge! tracks: tracks, score: (sum / tracks.length)
    end
  end

  def display_output
    @reports.each do |report|
      puts "Report #{report[:id]} Overall Score: #{report[:score]}"
      report[:tracks].each do |track|
        puts "Track #{track[:id]} Score: #{track[:score]}"
      end
    end
  end
end
