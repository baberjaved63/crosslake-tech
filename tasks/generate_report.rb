require_relative "../services/generate_report_service"

GenerateReportService.new(ARGV[0]).call
