class DownloadStreaming
  class DownloadError < StandardError; end

  def initialize(url)
    @url = url
  end

  def execute
    Rails.logger.info "Downloading streaming: #{@url}"
    file_name_part = @url.match(%r{/([^/]+?)$})[1]
    command = "yt-dlp \"#{@url}\" -o '#{Rails.root}/tmp/live-stream#{file_name_part}.mp4'"
    Rails.logger.info "[SHELL] #{command}"
    _stdout, stderr, _status = Open3.capture3(command)
    raise DownloadError, "Failed to download streaming: #{stderr}" unless _status.success?

    movie_path = "#{Rails.root}/tmp/live-stream#{file_name_part}.mp4"
    if block_given?
      yield movie_path
      FileUtils.rm_f(movie_path)
    else
      Rails.logger.info "you need to remove #{movie_path} manually!"
    end

    Rails.logger.info "Downloaded streaming: #{movie_path}"
    movie_path
  end
end
