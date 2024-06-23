class DownloadStreaming
  class DownloadError < StandardError; end

  def initialize(url)
    @url = url
  end

  def execute
    file_name_part = @url.match(%r{/([^/]+?)$})[1]
    command = "yt-dlp \"#{@url}\" -o '#{Rails.root}/live-stream#{file_name_part}'"
    _stdout, stderr, _status = Open3.capture3(command)
    raise DownloadError, "Failed to download streaming: #{stderr}" unless _status.success?

    movie_path = "#{Rails.root}/live-stream#{file_name_part}.mp4"
    if block_given?
      yield movie_path
      FileUtils.rm_f("#{Rails.root}/live-stream#{file_name_part}.info.json")
    else
      Rails.logger.info "you need to remove #{movie_path} manually!"
    end
    movie_path
  end
end
