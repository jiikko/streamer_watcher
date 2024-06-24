# NOTE: twitcastのみに対応
class DescribeStreaming
  class NotLiveResult
    def streaming?
      false
    end
  end

  class Result
    def initialize(json)
      @json = json.slice('id', 'title', 'epoch', 'is_live')
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
    base_path = "#{Rails.root}/tmp/live-stream#{file_name_part}"
    output_path = "#{base_path}.info.json"

    command = "yt-dlp \"#{@url}\" --skip-download --write-info-json -o '#{base_path}'"
    if ShellRunner.run(command)
      json = JSON.parse(File.read(output_path))
      FileUtils.rm_f(output_path)
      Result.new(json)
    else
      NotLiveResult.new
    end
  rescue Errno::EIO => e
    Rails.logger.error "Error: #{e}"
  end
end
