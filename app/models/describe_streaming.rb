require 'open3'

class DescribeStreaming
  class NotLiveResult
    def streaming?
      false
    end
  end

  class Result
    def initialize(json)
      @json = json
    end

    def streaming?
      @json['is_live']
    end
  end

  def initialize(url)
    @url = url.remove(%r{/$})
  end

  def execute
    file_name_part = @url.match(%r{/([^/]+?)$})[1]
    command = "yt-dlp \"#{@url}\" --skip-download --write-info-json -o '#{Rails.root}/live-stream#{file_name_part}'"
    _stdout, stderr, _status = Open3.capture3(command)
    return NotLiveResult.new if stderr.include?('The channel is not currently live')

    json = JSON.parse(File.read("#{Rails.root}/live-stream#{file_name_part}.info.json"))
    FileUtils.rm_f("#{Rails.root}/live-stream#{file_name_part}.info.json")
    Result.new(json)
  end
end
