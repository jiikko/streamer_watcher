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

    stdout, _stdin, pid = PTY.spawn(command)
    Rails.logger.info stdout.map(&:itself).join
    _, status = Process.wait2(pid)
    return NotLiveResult.new unless status.success?

    json = JSON.parse(File.read("#{Rails.root}/tmp/live-stream#{file_name_part}.info.json"))
    FileUtils.rm_f("#{Rails.root}/tmp/live-stream#{file_name_part}.info.json")
    Result.new(json)
  rescue Errno::EIO => e
    Rails.logger.error "Error: #{e}"
  end
end
