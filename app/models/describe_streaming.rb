require 'open3'

# NOTE: twitcastのみに対応
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

    def start_at
      Time.at(@json['epoch'])
    end

    def title
      @json['title']
    end

    def unique_key
      @json['id']
    end
  end

  def initialize(url)
    @url = url.remove(%r{/$})
  end

  def execute
    file_name_part = @url.match(%r{/([^/]+?)$})[1].gsub(':', '-')
    command = "yt-dlp \"#{@url}\" --skip-download --write-info-json -o '#{Rails.root}/tmp/live-stream#{file_name_part}'"
    Rails.logger.info "[SHELL] #{command}"
    _stdout, stderr, status = Open3.capture3(command)
    return NotLiveResult.new if stderr.include?('The channel is not currently live') || !status.success?

    json = JSON.parse(File.read("#{Rails.root}/tmp/live-stream#{file_name_part}.info.json"))
    FileUtils.rm_f("#{Rails.root}/tmp/live-stream#{file_name_part}.info.json")
    Result.new(json)
  end
end
