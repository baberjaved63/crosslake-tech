require_relative "../../services/generate_report_service"

describe GenerateReportService do

  describe "#call" do
    let!(:file_path) { "spec/samples/test_input.txt" }
    let!(:service) { GenerateReportService.new(file_path) }

    it "prints out correct report data" do
      expect { service.call }.to output(/Overall Score: 156/).to_stdout
    end
  end

end
